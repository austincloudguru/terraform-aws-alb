#------------------------------------------------------------------------------
# Create the ALB if Requested
#------------------------------------------------------------------------------
resource "aws_security_group" "this" {
  count       = var.create_alb ? 1 : 0
  name        = var.alb_name
  description = "Security Group for $[var.ecs_cluster_name}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      from_port   = lookup(ingress.value, "from_port", null )
      protocol    = lookup(ingress.value, "protocol", null )
      to_port     = lookup(ingress.value, "to_port", null )
      cidr_blocks = lookup(ingress.value, "cidr_blocks", null )
    }
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    {
      "Name" = var.alb_name
    },
    var.tags
  )
}

resource "aws_lb" "this" {
  count                      = var.create_alb ? 1 : 0
  name                       = var.alb_name
  load_balancer_type         = "application"
  internal                   = var.alb_internal
  enable_deletion_protection = var.enable_deletion_protection
  security_groups = [
    aws_security_group.this[0].id
  ]
  subnets = var.subnets
  dynamic "access_logs" {
    for_each = var.access_logs
    content {
      bucket  = lookup(access_logs.value, "bucket", null )
      prefix  = lookup(access_logs.value, "prefix", null )
      enabled = lookup(access_logs.value, "true", null )
    }
  }
  tags = {
    Name = var.alb_name
  }
}

#------------------------------------------------------------------------------
# Create the HTTPS listener if requested
#------------------------------------------------------------------------------
resource "aws_acm_certificate" "acm_cert" {
  count             = var.create_https_listener ? 1 : 0
  domain_name       = "*.${var.tld}"
  validation_method = "DNS"
}

resource "aws_route53_record" "cert_validation_record" {
  count   = var.create_https_listener ? 1 : 0
  name    = aws_acm_certificate.acm_cert[0].domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.acm_cert[0].domain_validation_options.0.resource_record_type
  zone_id = var.r53_zone_id
  records = [aws_acm_certificate.acm_cert[0].domain_validation_options.0.resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "default" {
  count                   = var.create_https_listener ? 1 : 0
  certificate_arn         = aws_acm_certificate.acm_cert[0].arn
  validation_record_fqdns = [aws_route53_record.cert_validation_record[0].fqdn]
}

resource "aws_lb_listener" "https_alb_listener" {
  count = var.create_https_listener ? 1 : 0
  load_balancer_arn = var.create_alb ? aws_lb.this[0].arn : var.load_balancer_arn
  port              = var.https_listener_port
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = aws_acm_certificate.acm_cert[0].arn

  default_action {
    type             = "fixed-response"

    fixed_response {
      content_type = var.fixed_response_content_type
      message_body = var.fixed_response_message_body
      status_code =  var.fixed_response_status_code
    }
  }
}