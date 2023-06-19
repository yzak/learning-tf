# モジュールが必要とする値を定義
variable "prefix" {
  type = string
}

variable "host_zone_name" {
  type = string
}

variable "host_name" {
  type = string
}

variable "dns_name" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "domain_validation_options" {
  type = set(any)
}
