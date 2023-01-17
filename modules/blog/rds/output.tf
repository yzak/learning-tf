# モジュールが呼び出し元に返す値を定義
output "address" {
  value = aws_db_instance.main.address
}
