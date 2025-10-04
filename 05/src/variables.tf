###cloud vars
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

### network block ============================================================
variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"

  validation {
    condition     = can(regex("^ru-central1-[abc]$", var.default_zone))
    error_message = "Zone must be one of: ru-central1-a, ru-central1-b."
  }
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"

  validation {
    condition     = can(cidrhost(var.default_cidr[0], 0))
    error_message = "CIDR must be a valid IPv4 CIDR block (e.g., 10.0.1.0/24)."
  }
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"

  validation {
    condition     = length(var.vpc_name) > 0
    error_message = "Environment name cannot be empty."
  }

  validation {
    condition     = contains(["develop", "stage", "prod"], var.vpc_name)
    error_message = "Environment name must be one of: develop, stage, prod."
  }
}

variable "image_family" {
  type = string
  default = "ubuntu-2004-lts"
}

###common vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = ""
#   description = "ssh-keygen -t ed25519"
# }

###example vm_web var
# variable "vm_web_name" {
#   type        = string
#   default     = "netology-develop-platform-web"
#   description = "example vm_web_ prefix"
# }

###example vm_db var
# variable "vm_db_name" {
#   type        = string
#   default     = "netology-develop-platform-db"
#   description = "example vm_db_ prefix"
# }





