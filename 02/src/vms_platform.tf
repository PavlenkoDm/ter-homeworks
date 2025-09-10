###compute image vars================================================
variable "vm_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS image family for compute instance"
}

###vm_web vars (первая ВМ)==========================================
# variable "vm_web_name" {
#   type        = string
#   default     = "netology-develop-platform-web"
#   description = "Name of the web VM instance"
# }

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID for web VM"
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

# variable "vm_web_cores" {
#   type        = number
#   default     = 2
#   description = "Number of CPU cores for web VM"
# }

# variable "vm_web_memory" {
#   type        = number
#   default     = 2
#   description = "Amount of memory (GB) for web VM"
# }

# variable "vm_web_core_fraction" {
#   type        = number
#   default     = 20
#   description = "Core fraction for web VM (% of CPU performance)"
# }

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Enable preemptible mode for web VM"
}

variable "vm_web_nat" {
  type = bool
  default = true
  description = "Enable nat for network interface"
}

###vm_db vars (вторая ВМ)============================================
# variable "vm_db_name" {
#   type        = string
#   default     = "netology-develop-platform-db"
#   description = "Name of the db VM instance"
# }

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID for db VM"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Availability zone for db VM"
}

variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

# variable "vm_db_cores" {
#   type        = number
#   default     = 2
#   description = "Number of CPU cores for db VM"
# }

# variable "vm_db_memory" {
#   type        = number
#   default     = 2
#   description = "Amount of memory (GB) for db VM"
# }

# variable "vm_db_core_fraction" {
#   type        = number
#   default     = 20
#   description = "Core fraction for db VM (% of CPU performance)"
# }

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Enable preemptible mode for db VM"
}

variable "vm_db_nat" {
  type = bool
  default = true
  description = "Enable nat for network interface"
}



