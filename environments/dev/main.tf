#----------------------------------------
# AWSのリージョン指定
#----------------------------------------
provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      Env       = "dev"
      Project   = "myproject"
      ManagedBy = "Terraform"
    }
  }
}

#----------------------------------------
# my-ip取得用
#----------------------------------------
provider "http" {
}


#----------------------------------------
# Terraformバージョンの指定
# AWSプロバイダバージョンの指定
#----------------------------------------
terraform {
  required_version = ">= 1.3.6"

  required_providers {
    aws = "4.45.0"
  }
}


#----------------------------------------
# VPCの作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
#----------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/21"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "myproject-dev-vpc"
  }
}

#----------------------------------------
# インターネットゲートウェイの作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
#----------------------------------------
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "myproject-dev-internet-gateway"
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
    Name = "myproject-dev-public-1a"
  }
}

resource "aws_subnet" "public-1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "myproject-dev-public-1c"
  }
}

#----------------------------------------
# ルートテーブルの作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
#----------------------------------------
resource "aws_route_table" "public-1a" {
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "myproject-dev-public-1a-rtb"
  }
}

resource "aws_route_table" "public-1c" {
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "myproject-dev-public-1c-rtb"
  }
}

#----------------------------------------
# IGW用のルート作成
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
#----------------------------------------
resource "aws_route" "igw-1a" {
  route_table_id         = aws_route_table.public-1a.id
  gateway_id             = aws_internet_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "igw-1c" {
  route_table_id         = aws_route_table.public-1c.id
  gateway_id             = aws_internet_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}

#----------------------------------------
# サブネットにルートテーブルを紐づけ
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
#----------------------------------------

# パブリックサブネットにルートテーブルを紐づけ
resource "aws_route_table_association" "public-1a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public-1a.id
}

resource "aws_route_table_association" "public-1c" {
  subnet_id      = aws_subnet.public-1c.id
  route_table_id = aws_route_table.public-1c.id
}

# my ip 取得
data "http" "myip" {
  url = "http://ipv4.icanhazip.com/"
}

# Security Group EC2
resource "aws_security_group" "main" {
  name        = "myproject-dev-ec2-sg"
  description = "myproject-dev-ec2-sg"
  vpc_id      = aws_vpc.main.id

  # アウトバウンドは全て許可
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "myproject-dev-ec2-sg"
  }
}

# SSHの許可
resource "aws_security_group_rule" "inboud_ssh" {
  security_group_id = aws_security_group.main.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = [
    "${chomp(data.http.myip.response_body)}/32" # https://developer.hashicorp.com/terraform/language/functions/chomp
  ]
  description = "ssh"
}

# KeyPairを登録
resource "aws_key_pair" "main" {
  key_name   = "myproject-dev-ec2"
  public_key = file("myproject-dev-ec2.pem.pub")
}

# EC2
resource "aws_instance" "main" {
  ami                         = "ami-0bba69335379e17f8"
  vpc_security_group_ids      = [aws_security_group.main.id]
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-1a.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.main.key_name
  tags = {
    "Name" = "myproject-dev-ec2"
  }
}

output "ec2_public_ip" {
  value = aws_instance.main.public_ip
}
