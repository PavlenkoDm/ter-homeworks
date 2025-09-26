# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }
# resource "yandex_vpc_subnet" "develop" {
#   name           = var.vpc_name
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr
# }

module "vpc_dev" {
  source   = "./vpc"
  env_name = var.vpc_name
  zone     = var.default_zone
  cidr     = var.default_cidr[0]
}


data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  
  vars = {
    ssh_public_key = file("~/.ssh/id_ed25519.pub")
  }
}

module "marketing_vm" {
  source = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  env_name = var.vpc_name

  network_id = module.vpc_dev.network_id
  subnet_zones = [var.default_zone]
  subnet_ids = [module.vpc_dev.subnet_id]

  instance_name = "marketing-web"
  instance_count = 1

  image_family = var.image_family

  public_ip = true
  
  labels = { 
    owner   = "student",
    project = "marketing"
  }

  metadata = {
    user-data = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

  env_name       = var.vpc_name

  network_id     = module.vpc_dev.network_id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_dev.subnet_id]

  instance_name  = "analytics-web"
  instance_count = 1

  image_family   = var.image_family
  
  public_ip      = true

  labels = { 
    owner   = "student",
    project = "analytics"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

