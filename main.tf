#----------------------------------------
# Terraformバージョン、AWSプロバイダバージョンの指定はversions.tfへ移動
#----------------------------------------

#----------------------------------------
# AWSのリージョン指定は、provider.tfへ移動
#----------------------------------------

#----------------------------------------
# VPCの作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
#----------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/21"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "myproject-vpc"
  }
}

#----------------------------------------
# インターネットゲートウェイの作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
#----------------------------------------
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "myproject-internet-gateway"
  }
}

#----------------------------------------
# サブネットの作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
#----------------------------------------

# パブリックサブネットの作成
resource "aws_subnet" "public-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "myproject-public-subnet-1a"
  }
}

resource "aws_subnet" "public-1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "myproject-public-subnet-1c"
  }
}

#----------------------------------------
# ルートテーブルの作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
#----------------------------------------
#  パブリックサブネットのルートテーブルの作成
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  #インターネットゲートウェイ向けのルート追加
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "myproject-public-rtb"
  }
}

#----------------------------------------
# サブネットにルートテーブルを紐づけ
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
#----------------------------------------

# パブリックサブネットにルートテーブルを紐づけ
resource "aws_route_table_association" "public-1a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-1c" {
  subnet_id      = aws_subnet.public-1c.id
  route_table_id = aws_route_table.public.id
}

