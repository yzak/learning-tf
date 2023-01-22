# my ip 取得
data "http" "myip" {
  url = "http://ipv4.icanhazip.com/"
}

# Security Group EC2
resource "aws_security_group" "main" {
  name        = "${var.prefix}-ec2-sg"
  description = "${var.prefix}-ec2-sg"
  vpc_id      = var.vpc_id

  # アウトバウンドは全て許可
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.prefix}-ec2-sg"
  }
}

# SSHの許可
resource "aws_security_group_rule" "inboud_ssh" {
  security_group_id = aws_security_group.main.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = [
    "${chomp(data.http.myip.body)}/32" # https://developer.hashicorp.com/terraform/language/functions/chomp
  ]
  description = "ssh"
}

# ELBからのインバウンド許可
resource "aws_security_group_rule" "inboud_http" {
  security_group_id        = aws_security_group.main.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = var.elb_sgr_id
  description              = "http"
}

# KeyPairを登録
resource "aws_key_pair" "main" {
  key_name   = "${var.prefix}-ec2"
  public_key = file("myproject-dev-ec2.pem.pub")
}

# EC2
resource "aws_instance" "main" {
  ami                         = "ami-0bba69335379e17f8"
  vpc_security_group_ids      = [aws_security_group.main.id]
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.main.key_name
  tags = {
    "Name" = "${var.prefix}-ec2"
  }
}

