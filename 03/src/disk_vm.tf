resource "yandex_compute_disk" "storage_disk" {
  count = var.count_storage_disk
  
  name     = "storage-disk-${count.index + 1}"
  type     = var.vms_storage_resources.additional_disks.type
  zone     = var.default_zone
  size     = var.vms_storage_resources.additional_disks.size
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.vm_platform_id  
  zone        = var.default_zone

  resources {
    cores  = var.vms_storage_resources.vm.cores
    memory = var.vms_storage_resources.vm.memory
    core_fraction = var.vms_storage_resources.vm.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vms_storage_resources.vm.boot_disk_size
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk
    content {
      disk_id     = secondary_disk.value.id
      auto_delete = var.disk_auto_delete
    }
  }

  scheduling_policy {
    preemptible = var.vm_storage_preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop_db.id
    nat                = var.vm_storage_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = merge(var.vms_metadata.common, {
    ssh-keys = "ubuntu:${local.ssh_key}"
  })
}