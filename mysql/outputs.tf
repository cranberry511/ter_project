output "cluster_id" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.id
}

output "fqdn" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.host[0].fqdn
}