# モジュールが呼び出し元に返す値を定義
output "fqdn" {
  value = aws_route53_record.main.fqdn
}
output "records" {
  value = [for record in aws_route53_record.validation : record.fqdn]
}
