# モジュールが呼び出し元に返す値を定義
output "sgr_id" {
  value = aws_security_group.main.id
}

output "launch_template_id" {
  value = aws_launch_template.main.id
}
