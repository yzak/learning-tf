# モジュールが必要とする値を定義
variable "prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = map(object({
    id  = string
    arn = string
  }))
}

variable "private_subnets" {
  type = map(object({
    id  = string
    arn = string
  }))
}

variable "host_zone_name" {
  type = string
}

variable "elb_host_name" {
  type = string
}

variable "cdn_host_name" {
  type = string
}
