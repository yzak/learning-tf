# モジュールが呼び出し元に返す値を定義
output "rds_address" {
  value = module.rds.address
}
output "elb_dns_name" {
  value = module.elb.dns_name
}
output "elb_fqdn" {
  value = module.elb_route53.fqdn
}
output "cdn_fqdn" {
  value = module.cdn_route53.fqdn
}
