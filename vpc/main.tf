resource "yandex_vpc_network" "develop" {
  name = var.env_name
}
resource "yandex_vpc_subnet" "develop" {
  for_each = { for net in var.subnets : net.zone => net }
  name           = "${var.env_name}-${each.key}"
  zone           = each.key
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [each.value.cidr]
}

