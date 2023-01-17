# モジュールが呼び出し元に返す値を定義
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public
}
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private
}
