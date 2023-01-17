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
  }
  private_subnets = {
    private-1a = {
      name = "private-1a"
      cidr = "10.0.2.0/24"
      az   = "ap-northeast-1a"
    },
    private-1c = {
      name = "private-1c"
      cidr = "10.0.3.0/24"
      az   = "ap-northeast-1c"
    },
  }
  prefix = "${data.aws_default_tags._.tags.Project}-${data.aws_default_tags._.tags.Env}"
}

# モジュールの呼び出し
# module "リソースの名前(自由)"
# source = "モジュールを定義したフォルダのパス"
# パラメータ名(variables.tfで定義した名前) = モジュールに渡す値
module "base" {
  source          = "../../modules/base"
  prefix          = local.prefix
  vpc_cidr_block  = local.vpc_cidr_block
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
}

module "blog" {
  source         = "../../modules/blog"
  prefix         = local.prefix
  vpc_id         = module.base.vpc_id
  public_subnets = module.base.public_subnets
}

# モジュールの呼び出し結果の値を表示してみる
# module.リソース名.output.tfの名前でアクセス可能
output "vpc_id" {
  value = module.base.vpc_id
}

output "public_subnet_1a" {
  value = module.base.public_subnets["public-1a"].id
}

output "public_subnet_ids" {
  value = [for value in module.base.public_subnets : value.id]
}

output "private_subnet_1a" {
  value = module.base.private_subnets["private-1a"].id
}

output "private_subnet_ids" {
  value = [for value in module.base.private_subnets : value.id]
}

output "ec2_public_ip" {
  value = module.blog.ec2_public_ip
}
