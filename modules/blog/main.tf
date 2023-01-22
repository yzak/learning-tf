module "ec2" {
  source     = "./ec2"
  prefix     = var.prefix
  vpc_id     = var.vpc_id
  subnet_id  = var.public_subnets["public-1a"].id
  elb_sgr_id = module.elb.sgr_id
}

module "rds" {
  source          = "./rds"
  prefix          = var.prefix
  vpc_id          = var.vpc_id
  ec2_sgr_id      = module.ec2.sgr_id
  private_subnets = var.private_subnets
}

module "elb" {
  source         = "./elb"
  prefix         = var.prefix
  vpc_id         = var.vpc_id
  public_subnets = var.public_subnets
  instance_id    = module.ec2.instance_id
}
