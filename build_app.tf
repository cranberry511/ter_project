resource "local_file" "build_app_script" {
  filename = "build_app.sh"

  content  = templatefile("./build_app.tpl", {
    registry_name   = yandex_container_registry.my-reg.id
  })
}