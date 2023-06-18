# モジュールが呼び出し元に返す値を定義
output "rds_address" {
  value = module.rds.address
}
output "elb_dns_name" {
  value = module.elb.dns_name
}
output "fqdn" {
  value = module.route53.fqdn
}
