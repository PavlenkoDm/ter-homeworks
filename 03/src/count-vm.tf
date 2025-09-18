resource "yandex_compute_instance" "web" {
  count = var.count_vms_web

  name        = "web-${count.index + 1}"
  platform_id = var.vm_platform_id
  zone        = var.default_zone

  resources {
    cores         = var.vms_web_resources.cores          
    memory        = var.vms_web_resources.memory           
    core_fraction = var.vms_web_resources.core_fraction  
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vms_web_resources.disk_volume       
    }
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_web_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = merge(var.vms_metadata.common, {
    ssh-keys = "ubuntu:${local.ssh_key}"
  })

  depends_on = [yandex_compute_instance.db]
}