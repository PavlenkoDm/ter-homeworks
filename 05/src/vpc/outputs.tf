output "network" {
  description = "VPC network information"
  value       = yandex_vpc_network.vpc
}

output "subnet" {
  description = "Subnet information"
  value       = yandex_vpc_subnet.subnet
}

output "network_id" {
  description = "VPC ID"
  value       = yandex_vpc_network.vpc.id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = yandex_vpc_subnet.subnet.id
}

output "subnet_zone" {
  description = "Subnet zone"
  value       = yandex_vpc_subnet.subnet.zone
}