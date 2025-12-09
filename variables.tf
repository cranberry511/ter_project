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

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = string
  default     = "10.0.3.0/24"
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###common vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "your_ssh_ed25519_key"
  description = "ssh-keygen -t ed25519"
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2404-lts"
}

variable "instance_count" {
  type        = number
  default     = 1
}

variable "public_ip" {
  type        = bool
  default     = true
}

variable "platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "vm_cpu" {
  type        = number
  default     = 2
}

variable "vm_ram" {
  type        = number
  default     = 4
}

variable "vm_core_fraction" {
  type        = number
  default     = 20
}

variable "db_name" {
  type        = string
  default     = "virtd"
}

variable "db_user" {
  type        = string
  default     = "app"
}

variable "db_cluster_name" {
  type        = string
  default     = "my_cluster"
}