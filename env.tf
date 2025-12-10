resource "local_file" "hosts_for" {
  content =  <<-EOT
  TABLE_NAME='requests'
  DB_HOST='${module.mysql_cluster.fqdn}'
  DB_USER='${var.db_user}'
  DB_PASSWORD='${data.yandex_lockbox_secret_version.db_password.entries[0]["text_value"]}'
  DB_NAME='${var.db_name}'
   EOT
  filename = "${abspath(path.module)}/.env"
}