# モジュールが必要とする値を定義
variable "prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ec2_sgr_id" {
  type = string
}

variable "private_subnets" {
  type = map(object({
    id  = string
    arn = string
  }))
}
