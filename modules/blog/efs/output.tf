# モジュールが呼び出し元に返す値を定義
output "efs_id" {
  value = aws_efs_file_system.main.id
}
