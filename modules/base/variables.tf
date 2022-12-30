# モジュールが必要とする値を定義
variable "prefix" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnets" {
  type = map(object({
    name = string
    cidr = string
    az   = string
  }))
}
