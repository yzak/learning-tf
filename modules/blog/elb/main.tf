# my ip 取得
data "http" "myip" {
  url = "http://ipv4.icanhazip.com/"
}

# Security Group ELB
resource "aws_security_group" "main" {
  name        = "${var.prefix}-elb-sg"
  description = "${var.prefix}-elb-sg"
  vpc_id      = var.vpc_id

  # インバウンドはHTTPを許可
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      "${chomp(data.http.myip.body)}/32" # https://developer.hashicorp.com/terraform/language/functions/chomp
    ]
  }

  # アウトバウンドは全て許可
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.prefix}-elb-sg"
  }
}

# ELB
resource "aws_lb" "main" {
  name               = "${var.prefix}-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main.id]
  subnets            = [for value in var.public_subnets : value.id]
}

# Instance Target Group
resource "aws_lb_target_group" "main" {
  name     = "${var.prefix}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path = "/healthcheck.html"
  }
}

# Target Group Attachment
resource "aws_alb_target_group_attachment" "main" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = var.instance_id
  port             = 80
}

# ELB Listener
resource "aws_alb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = "forward"
  }
}

