resource "yandex_compute_instance" "db" {
  for_each = {
    for vm in var.each_vm_db : vm.vm_name => vm
  }

  name        = "db-${each.value.vm_name}"
  platform_id = var.vm_platform_id
  zone        = var.default_zone

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
    }
  }

  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop_db.id
    nat                = var.vm_db_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = merge(var.vms_metadata.common, {
    ssh-keys = "ubuntu:${local.ssh_key}"
  })
}