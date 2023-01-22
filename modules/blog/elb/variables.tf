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

variable "instance_id" {
  type = string
}

