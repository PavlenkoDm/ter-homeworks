###cloud vars===========================================
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###ssh vars===================================================

variable "vms_ssh_root_key" {
  type        = string
  default     = ""
  description = "ssh-keygen -t ed25519"
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

###compute image vars================================================
variable "vm_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS image family for compute instance"
}

###platform id vars=====================================================
variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID for db & VM"
}

###db vm vars===========================================================
variable "each_vm_db" {
  type = list(object({
    vm_name = string
    cpu = number 
    ram = number
    core_fraction = number
    disk_volume = number
  }))
  default = [
    {
      vm_name = "main"
      cpu = 4
      ram = 4
      core_fraction = 20
      disk_volume = 10
    },
    {
      vm_name = "replica"  
      cpu = 2
      ram = 2
      core_fraction = 20
      disk_volume = 10
    }
  ]
}

variable "vm_db_nat" {
  type = bool
  default = true
  description = "Enable nat for network interface"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Enable preemptible mode for db VM"
}

###storage vm vars=====================================================
variable "count_storage_disk" {
  type = number
  default = 3
  description = "Count of the storage disks"
}

variable "vms_storage_resources" {
  description = "Resources for storage VM and its disks"
  type = object({
    vm = object({
      cores         = number
      memory        = number
      core_fraction = number
      boot_disk_size = number
    })
    additional_disks = object({
      type = string
      size = number
    })
  })
  default = {
    vm = {
      cores         = 2
      memory        = 2  
      core_fraction = 20
      boot_disk_size = 10
    }
    additional_disks = {
      type = "network-hdd"
      size = 1
    }
  }
}

variable "vm_storage_nat" {
  type = bool
  default = true
  description = "Enable nat for network interface"
}

variable "vm_storage_preemptible" {
  type        = bool
  default     = true
  description = "Enable preemptible mode for storage VM"
}

variable "disk_auto_delete" {
  type = bool
  default = true
  description = "Disk deleting flag"
}

###web vm vars==========================================================
variable "vms_web_resources" {
  description = "Resources configuration for web VMs"
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_volume   = number
  })
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
    disk_volume   = 10
  }
}

variable "count_vms_web" {
  type = number
  default = 2
  description = "Count of the vms"
}

variable "vm_web_nat" {
  type = bool
  default = true
  description = "Enable nat for network interface"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Enable preemptible mode for web VM"
}