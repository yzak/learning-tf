data "aws_default_tags" "_" {}
locals {
  vpc_cidr_block = "10.0.0.0/21"
  public_subnets = {
    public-1a = {
      name = "public-1a"
      cidr = "10.0.0.0/24"
      az   = "ap-northeast-1a"
    },
    public-1c = {
      name = "public-1c"
      cidr = "10.0.1.0/24"
      az   = "ap-northeast-1c"
    },
    public-1d = {
      name = "public-1d"
      cidr = "10.0.2.0/24"
      az   = "ap-northeast-1d"
    },
  }
  prefix = "${data.aws_default_tags._.tags.Project}-${data.aws_default_tags._.tags.Env}"
}

module "vpc" {
  source         = "../../modules/network/vpc"
  prefix         = local.prefix
  vpc_cidr_block = local.vpc_cidr_block
  public_subnets = local.public_subnets
}
