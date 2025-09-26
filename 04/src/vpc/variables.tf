variable "env_name" {
  description = "Env name for prefix (develop, stage, prod)"
  type        = string
  
  validation {
    condition     = length(var.env_name) > 0
    error_message = "Environment name cannot be empty."
  }
}

variable "zone" {
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
  type        = string
  
  validation {
    condition     = can(regex("^ru-central1-[abc]$", var.zone))
    error_message = "Zone must be one of: ru-central1-a, ru-central1-b."
  }
}

variable "cidr" {
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
  type        = string
  
  validation {
    condition     = can(cidrhost(var.cidr, 0))
    error_message = "CIDR must be a valid IPv4 CIDR block (e.g., 10.0.1.0/24)."
  }
}