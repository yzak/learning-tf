#----------------------------------------
# Terraformバージョンの指定
# AWSプロバイダバージョンの指定
#----------------------------------------
terraform {
  required_version = "1.3.6"

  required_providers {
    aws = "4.45.0"
  }
}

#----------------------------------------
# AWSのリージョン指定
#----------------------------------------
provider "aws" {
  region = "ap-northeast-1"
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

