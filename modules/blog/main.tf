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

module "route53" {
  source         = "./route53"
  prefix         = var.prefix
  host_zone_name = var.host_zone_name
  elb_host_name  = var.elb_host_name
  elb_dns_name   = module.elb.dns_name
  elb_zone_id    = module.elb.zone_id
}
