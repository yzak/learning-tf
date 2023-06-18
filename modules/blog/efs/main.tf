resource "aws_efs_file_system" "main" {
  tags = {
    Name = "${var.prefix}-efs"
  }
}

resource "aws_efs_mount_target" "private1a" {
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.private_subnets["private-1a"].id
  security_groups = [aws_security_group.main.id]
}

resource "aws_efs_mount_target" "private1c" {
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.private_subnets["private-1c"].id
  security_groups = [aws_security_group.main.id]
}

resource "aws_security_group" "main" {
  name        = "${var.prefix}-efs-sg"
  description = "${var.prefix}-efs-sg"
  vpc_id      = var.vpc_id
  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [var.ec2_sgr_id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
