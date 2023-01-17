module "ec2" {
  source    = "./ec2"
  prefix    = var.prefix
  vpc_id    = var.vpc_id
  subnet_id = var.public_subnets["public-1a"].id
}

module "rds" {
  source          = "./rds"
  prefix          = var.prefix
  vpc_id          = var.vpc_id
  ec2_sgr_id      = module.ec2.sgr_id
  private_subnets = var.private_subnets
}
