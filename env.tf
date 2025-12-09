resource "local_file" "hosts_for" {
  content =  <<-EOT
  TABLE_NAME='requests'
  DB_HOST='${module.mysql_cluster.fqdn}'
  DB_USER='${var.db_user}'
  DB_PASSWORD='${random_password.db_pass.result}'
  DB_NAME='${var.db_name}'
   EOT
  filename = "${abspath(path.module)}/.env"
}