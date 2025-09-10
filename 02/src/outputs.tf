output "vms_info" {
  description = "Information about all VMs"
  value = {
    web_vm = {
      instance_name = yandex_compute_instance.platform.name
      external_ip   = yandex_compute_instance.platform.network_interface[0].nat_ip_address
      fqdn         = yandex_compute_instance.platform.fqdn
    }
    db_vm = {
      instance_name = yandex_compute_instance.platform_db.name
      external_ip   = yandex_compute_instance.platform_db.network_interface[0].nat_ip_address
      fqdn         = yandex_compute_instance.platform_db.fqdn
    }
  }
}