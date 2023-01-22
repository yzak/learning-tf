# モジュールが呼び出し元に返す値を定義
output "arn" {
  value = aws_lb.main.arn
}

output "dns_name" {
  value = aws_lb.main.dns_name
}

output "zone_id" {
  value = aws_lb.main.zone_id
}

output "sgr_id" {
  value = aws_security_group.main.id
}
