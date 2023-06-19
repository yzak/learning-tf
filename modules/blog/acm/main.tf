# ACM https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate.html
resource "aws_acm_certificate" "main" {
  domain_name               = var.host_zone_name
  validation_method         = "DNS"
  subject_alternative_names = [var.host_name]
  lifecycle {
    create_before_destroy = true
  }
}

# ACM Validation https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation.html
resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = var.validation_record_fqdns
}
