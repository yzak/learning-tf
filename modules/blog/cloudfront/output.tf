# モジュールが呼び出し元に返す値を定義
output "arn" {
  value = aws_cloudfront_distribution.main.arn
}

output "dns_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "zone_id" {
  value = aws_cloudfront_distribution.main.hosted_zone_id
}

