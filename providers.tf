terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "= 0.174"
    }
    template = {
      source = "hashicorp/template"
      version = "= 2.2.0"
    }
    null = {
      source = "hashicorp/null"
      version = "= 3.2.4"
    }
    random = {
      source = "hashicorp/random"
      version = "= 3.7.2"
    }
    local = {
      source = "hashicorp/local"
      version = "= 2.6.1"
    }
  }
  required_version = "=1.14.0"

  backend "s3" {
    bucket  = "mybucket-slkdm4895h"
    key     = "terraform.tfstate"
    region  = "ru-central1"

    use_lockfile = true
    
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}