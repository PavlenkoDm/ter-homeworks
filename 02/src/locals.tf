locals {
  web_vm_name = "${var.organization}-${var.environment}-${var.platform}-web"
  db_vm_name  = "${var.organization}-${var.environment}-${var.platform}-db"
}