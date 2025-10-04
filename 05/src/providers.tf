terraform {
  required_version = ">=1.8.4"

  backend "s3" {
    
    shared_credentials_files = ["~/.aws/credentials"]
    #shared_config_files = [ "~/.aws/config" ]
    profile = "default"
    region="ru-central1"

    bucket     = "pavlenko0710" #My_Bucket_in_Yandex
    key = "prod/terraform.tfstate"
    
    # access_key                  = "..."          #Только для примера! Не хардкодим секретные данные!
    # secret_key                  = "..."          #Только для примера! Не хардкодим секретные данные!

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

    endpoints ={
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gj6rttd3s5ov5caq4j/etnetnjh95fbdsk7ent3"
      s3 = "https://storage.yandexcloud.net"
    }

    dynamodb_table              = "tfstate-lock-tb"
  }

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.161.0"
    }

    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }  
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}