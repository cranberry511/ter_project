resource "yandex_mdb_mysql_database" "my_db" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "my_user" {
  depends_on = [yandex_mdb_mysql_database.my_db]
  cluster_id = var.cluster_id
  name       = var.db_user
  password   = var.db_password

  permission {
    database_name = var.db_name
    roles         = ["ALL"]
  }

  connection_limits {
    max_questions_per_hour   = 100
    max_updates_per_hour     = 200
    max_connections_per_hour = 300
    max_user_connections     = 40
  }

  global_permissions = ["PROCESS"]

}
