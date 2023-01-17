# モジュールが呼び出し元に返す値を定義
output "public_ip" {
  value = aws_instance.main.public_ip
}

output "sgr_id" {
  value = aws_security_group.main.id
}
