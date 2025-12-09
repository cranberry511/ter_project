resource "local_file" "compose" {
  filename = "compose.yaml"

  content  = templatefile("./compose.tpl", {
    registry_name   = yandex_container_registry.my-reg.id
  })
}