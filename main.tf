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
# Terraformバージョンの指定
# AWSプロバイダバージョンの指定
#----------------------------------------
terraform {
  required_version = ">= 1.4.6"

  required_providers {
    aws = "5.1.0"
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

