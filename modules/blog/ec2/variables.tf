# モジュールが必要とする値を定義
variable "prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "elb_sgr_id" {
  type = string
}

variable "efs_id" {
  type = string
}

variable "db_host" {
  type = string
}

variable "cdn_domain_name" {
  type = string
}
