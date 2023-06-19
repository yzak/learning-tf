resource "aws_cloudfront_distribution" "main" {
  aliases          = ["${var.cdn_domain_name}"]
  enabled          = true
  is_ipv6_enabled  = false
  retain_on_delete = false

  default_cache_behavior {
    allowed_methods        = ["HEAD", "OPTIONS", "GET", "PUT", "POST", "DELETE", "PATCH"]
    cached_methods         = ["HEAD", "OPTIONS", "GET"]
    compress               = true
    default_ttl            = 86400
    max_ttl                = 31536000
    min_ttl                = 0
    target_origin_id       = "elb"
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }

  origin {
    origin_id   = "elb"
    domain_name = var.elb_domain_name
    custom_header {
      name  = "x-pre-shared-token"
      value = var.pre_shared_token
    }
    custom_origin_config {
      origin_protocol_policy = "https-only"
      http_port              = 80
      https_port             = 443
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  price_class = "PriceClass_All"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.1_2016"
    ssl_support_method             = "sni-only"
  }
}

