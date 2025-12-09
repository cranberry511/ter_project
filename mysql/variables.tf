variable "name" {
  type        = string
}

variable "net_id" {
  type        = string
}

variable "subnet_id" {
  type        = string
}

variable "HA" {
  type        = bool
  default = true
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "mysql_version" {
  type        = string
  default     = "8.0"
}

variable "resource_preset_id" {
  type        = string
  default     = "b1.medium"
}

variable "disk_type_id" {
  type        = string
  default     = "network-hdd"
}

variable "disk_size" {
  type        = number
  default     = 10
}


