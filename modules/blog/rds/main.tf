# Security Group
resource "aws_security_group" "main" {
  name        = "${var.prefix}-rds-sg"
  description = "${var.prefix}-rds-sg"
  vpc_id      = var.vpc_id

  # EC2からのみ許可
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sgr_id]
  }
  # アウトバウンドは全て許可
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.prefix}-rds-sg"
  }
}

# サブネットグループ
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
resource "aws_db_subnet_group" "main" {
  name       = "${var.prefix}-rds-subnetgroup"
  subnet_ids = [for value in var.private_subnets : value.id]
  tags = {
    Name = "${var.prefix}-rds-subnetgroup"
  }
}

# RDS
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
resource "aws_db_instance" "main" {
  identifier             = "wordpress"
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = "wordpress"
  username               = "wordpress"
  password               = "wordpress" # パスワードは構築後に変更する or tfvarsで指定するようにする
  vpc_security_group_ids = [aws_security_group.main.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot    = true
}
