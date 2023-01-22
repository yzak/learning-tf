# モジュールが呼び出し元に返す値を定義
output "ec2_public_ip" {
  value = module.ec2.public_ip
}
output "rds_address" {
  value = module.rds.address
}
output "elb_dns_name" {
  value = module.elb.dns_name
}
output "fqdn" {
  value = module.route53.fqdn
}
