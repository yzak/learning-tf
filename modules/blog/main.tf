module "efs" {
  source          = "./efs"
  prefix          = var.prefix
  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets
  ec2_sgr_id      = module.ec2.sgr_id
}

module "ec2" {
  source          = "./ec2"
  prefix          = var.prefix
  vpc_id          = var.vpc_id
  subnet_id       = var.public_subnets["public-1a"].id
  efs_id          = module.efs.efs_id
  elb_sgr_id      = module.elb.sgr_id
  db_host         = module.rds.address
  cdn_domain_name = var.cdn_host_name
}

module "rds" {
  source          = "./rds"
  prefix          = var.prefix
  vpc_id          = var.vpc_id
  ec2_sgr_id      = module.ec2.sgr_id
  private_subnets = var.private_subnets
}

locals {
  pre_shared_token = "Wef9_Jpe6-X4aK"
}

module "elb" {
  source             = "./elb"
  prefix             = var.prefix
  vpc_id             = var.vpc_id
  public_subnets     = var.public_subnets
  acm_arn            = module.elb_acm.arn
  launch_template_id = module.ec2.launch_template_id
  pre_shared_token   = local.pre_shared_token
}

module "cloudfront" {
  source           = "./cloudfront"
  prefix           = var.prefix
  cdn_domain_name  = var.cdn_host_name
  elb_domain_name  = var.elb_host_name
  acm_arn          = module.cdn_acm.arn
  pre_shared_token = local.pre_shared_token
}

module "elb_route53" {
  source                    = "./route53"
  prefix                    = var.prefix
  host_zone_name            = var.host_zone_name
  host_name                 = var.elb_host_name
  dns_name                  = module.elb.dns_name
  zone_id                   = module.elb.zone_id
  domain_validation_options = module.elb_acm.domain_validation_options
}

module "elb_acm" {
  source                  = "./acm"
  prefix                  = var.prefix
  host_zone_name          = var.host_zone_name
  host_name               = var.elb_host_name
  validation_record_fqdns = module.elb_route53.records
}

module "cdn_route53" {
  source                    = "./route53"
  prefix                    = var.prefix
  host_zone_name            = var.host_zone_name
  host_name                 = var.cdn_host_name
  dns_name                  = module.cloudfront.dns_name
  zone_id                   = module.cloudfront.zone_id
  domain_validation_options = module.cdn_acm.domain_validation_options
}

module "cdn_acm" {
  source                  = "./acm"
  prefix                  = var.prefix
  host_zone_name          = var.host_zone_name
  host_name               = var.cdn_host_name
  validation_record_fqdns = module.cdn_route53.records
  providers = {
    aws = aws.virginia
  }
}
