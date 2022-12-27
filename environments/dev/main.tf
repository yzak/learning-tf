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
  prefix = "${data.aws_default_tags._.tags.Project}-${data.aws_default_tags._.tags.Env}"
}

# モジュールの呼び出し
# module "リソースの名前(自由)"
# source = "モジュールを定義したフォルダのパス"
# パラメータ名(variables.tfで定義した名前) = モジュールに渡す値
module "vpc" {
  source         = "../../modules/network/vpc"
  prefix         = local.prefix
  vpc_cidr_block = local.vpc_cidr_block
  public_subnets = local.public_subnets
}

# モジュールの呼び出し結果の値を表示してみる
# module.リソース名.output.tfの名前でアクセス可能
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_1a" {
  value = module.vpc.public_subnets["public-1a"].id
}

output "public_subnet_ids" {
  value = [for value in module.vpc.public_subnets : value.id]
}
