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

variable "validation_record_fqdns" {
  type = list(string)
}
