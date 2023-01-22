# モジュールが呼び出し元に返す値を定義
output "domain_validation_options" {
  value = aws_acm_certificate.main.domain_validation_options
}

output "arn" {
  value = aws_acm_certificate_validation.main.certificate_arn
}
