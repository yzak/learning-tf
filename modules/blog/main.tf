module "ec2" {
  source    = "./ec2"
  prefix    = var.prefix
  vpc_id    = var.vpc_id
  subnet_id = var.public_subnets["public-1a"].id
}
