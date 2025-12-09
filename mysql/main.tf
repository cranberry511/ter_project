resource "yandex_mdb_mysql_cluster" "mysql_cluster" {
  name        = var.name
  environment = "PRESTABLE"
  network_id  = var.net_id
  version     = var.mysql_version

  resources {
    resource_preset_id = var.resource_preset_id
    disk_type_id       = var.disk_type_id
    disk_size          = var.disk_size
  }

  mysql_config = {
    sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    max_connections               = 100
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    innodb_print_all_deadlocks    = true

  }

  host {
    zone      = var.default_zone
    subnet_id = var.subnet_id
  }

  dynamic "host" {
    for_each = var.HA ? [1] : []
  content {
    zone      = var.default_zone
    subnet_id = var.subnet_id
  }
  }
  }

