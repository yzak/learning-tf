# モジュールが呼び出し元に返す値を定義
output "public_ip" {
  value = aws_instance.main.public_ip
}
