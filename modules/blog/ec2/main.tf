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
    "${chomp(data.http.myip.response_body)}/32" # https://developer.hashicorp.com/terraform/language/functions/chomp
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

resource "aws_launch_template" "main" {
  name          = "${var.prefix}-launch-template"
  image_id      = "ami-0bba69335379e17f8"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.main.key_name
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.main.id]
  }
  user_data = base64encode(templatefile("${path.module}/tpl/user_data.sh",
    {
      efs_id  = var.efs_id
      db_host = var.db_host
      cdn_domain_name = var.cdn_domain_name
    }
  ))
  tags = {
    "Name" = "${var.prefix}-ec2"
  }
}
