#----------------------------------------
# VPCの作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
#----------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

#----------------------------------------
# インターネットゲートウェイの作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
#----------------------------------------
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

#----------------------------------------
# サブネットの作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
#----------------------------------------

# パブリックサブネットの作成
resource "aws_subnet" "public" {
  for_each          = var.public_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.prefix}-${each.key}"
  }
}

#----------------------------------------
# ルートテーブルの作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
#----------------------------------------
resource "aws_route_table" "public" {
  for_each = var.public_subnets
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "${var.prefix}-${each.key}-rtb"
  }
}

#----------------------------------------
# IGW用のルート作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
#----------------------------------------
resource "aws_route" "igw" {
  for_each               = var.public_subnets
  route_table_id         = aws_route_table.public[each.key].id
  gateway_id             = aws_internet_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}

#----------------------------------------
# サブネットにルートテーブルを紐づけ
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
#----------------------------------------

# パブリックサブネットにルートテーブルを紐づけ
resource "aws_route_table_association" "public" {
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}
