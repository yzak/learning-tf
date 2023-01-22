# モジュールが呼び出し元に返す値を定義
output "fqdn" {
  value = aws_route53_record.main.fqdn
}
