module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = var.default_zone, cidr = var.default_cidr },
  ]
}

data "yandex_vpc_security_group" "my_sg" {
  name = "my_sg"
}

resource "random_password" "db_pass" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

data "yandex_compute_image" "my_image_family" {
  family = var.image_family
}

resource "yandex_container_registry" "my-reg" {
  name = "my-registry"
}

resource "yandex_compute_instance" "web" {
  depends_on = [module.mysql_db_user]
  name        = "web"
  zone           = var.default_zone
  platform_id = var.platform_id
  resources {
    cores         = var.vm_cpu
    memory        = var.vm_ram
    core_fraction = var.vm_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image_family.id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = module.vpc_dev.yandex_vpc_subnet[var.default_zone].id
    security_group_ids = [data.yandex_vpc_security_group.my_sg.id]
    nat       = true
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key     = file("~/.ssh/id_ed25519.pub")
  }
}

resource "null_resource" "run_docker_compose" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_ed25519")
    host        = yandex_compute_instance.web.network_interface[0].nat_ip_address
  }

  provisioner "file" {
    source      = "proxy.yaml"
    destination = "proxy.yaml"
  }

  provisioner "file" {
    source      = "compose.yaml"
    destination = "compose.yaml"
  }  

  provisioner "file" {
    source      = ".env"
    destination = ".env"
  }

  provisioner "file" {
    source      = "nginx"
    destination = "nginx"
  }

  provisioner "file" {
    source      = "haproxy"
    destination = "haproxy"
  }

  provisioner "file" {
    source      = "build_app.sh"
    destination = "/tmp/build_app.sh"
  } 

  provisioner "local-exec" {
    command = "sleep 60"
  }   

  provisioner "remote-exec" {
    inline = [
      "sudo usermod -aG docker ubuntu",
      "curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash",
      "docker login --username oauth --password ${var.token} cr.yandex",
      "chmod +x /tmp/build_app.sh",
      "/tmp/build_app.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "docker compose up -d",
      "docker logout cr.yandex",
      "sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8090"
    ]
  }
}

module "mysql_cluster" {
  source       = "./mysql"
  name     = var.db_cluster_name
  net_id = module.vpc_dev.yandex_vpc_network
  subnet_id = module.vpc_dev.yandex_vpc_subnet[var.default_zone].id
  HA = false
}

module "mysql_db_user" {
  depends_on = [module.mysql_cluster]
  source       = "./mysql_db_user"
  cluster_id = module.mysql_cluster.cluster_id
  db_name     = var.db_name
  db_user = var.db_user
  db_password = random_password.db_pass.result
}