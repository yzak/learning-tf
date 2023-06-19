# モジュールが必要とする値を定義
variable "prefix" {
  type = string
}

variable "cdn_domain_name" {
  type = string
}

variable "elb_domain_name" {
  type = string
}

variable "acm_arn" {
  type = string
}

variable "pre_shared_token" {
  type = string
}
