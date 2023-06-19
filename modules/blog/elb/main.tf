# Security Group ELB
resource "aws_security_group" "main" {
  name        = "${var.prefix}-elb-sg"
  description = "${var.prefix}-elb-sg"
  vpc_id      = var.vpc_id

  # インバウンドはHTTPを許可
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # インバウンドはHTTPSを許可
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    path = "/wp-includes/images/blank.gif"
  }
}

# ELB Listener HTTPS
resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.acm_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = 403
      message_body = "Forbidden"
    }
  }
}

resource "aws_lb_listener_rule" "tg" {
  listener_arn = aws_alb_listener.https.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    http_header {
      http_header_name = "x-pre-shared-token"
      values           = [var.pre_shared_token]
    }
  }
}

#HTTPリスナー
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  # HTTP -> HTTPSへリダイレクト
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# オートスケーリンググループ
resource "aws_autoscaling_group" "main" {
  name                = "${var.prefix}-autoscaling-group"
  max_size            = 4
  min_size            = 2
  desired_capacity    = 2
  vpc_zone_identifier = [for value in var.public_subnets : value.id]

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.main.arn]
  tag {
    key                 = "Name"
    value               = "${var.prefix}-autoscaling-instance"
    propagate_at_launch = true # 起動したインスタンスに付与するタグ
  }
}
