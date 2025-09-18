resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tftpl", {
    webservers = yandex_compute_instance.web
    databases  = values(yandex_compute_instance.db)  
    storage    = [yandex_compute_instance.storage]
  })
  
  filename = "${abspath(path.module)}/hosts.cfg"
}