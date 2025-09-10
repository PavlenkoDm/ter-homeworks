###cloud vars==============================================
variable "cloud_id" {
  type = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###ssh vars===================================================

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHerWUqm/ShY4pbAeY9PIYuBPWXBW9H+S2TT1sjSbdb tf_sa_key"
  description = "ssh-keygen -t ed25519"
}

###common naming vars==========================================
variable "organization" {
  type        = string
  default     = "netology"
  description = "Project name for resource naming"
}

variable "environment" {
  type        = string
  default     = "develop"
  description = "Environment name (develop, staging, production)"
}

variable "platform" {
  type        = string
  default     = "platform"
  description = "Platform type for resource naming"
}

###vms resources var=====================================================
variable "vms_resources" {
  description = "Resources configuration for VMs"
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
  default = {
    web = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 10
      hdd_type      = "network-hdd"
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 10
      hdd_type      = "network-ssd"
    }
  }
}

###vms metadata var=======================================================
variable "vms_metadata" {
  description = "Common metadata for all VMs"
  type = map(object({
    serial-port-enable = number
    ssh-keys = string
  }))
  default = {
    common = {
      serial-port-enable = 1
      ssh-keys           = ""
    }
  }
}