#------------------------------------------------------------------------------
# Create the ALB if Requested
#------------------------------------------------------------------------------
resource "aws_security_group" "this" {
  count       = var.create_alb ? 1 : 0
  name        = var.alb_name
  description = "Security Group for ${var.alb_name}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      from_port   = lookup(ingress.value, "from_port", null)
      protocol    = lookup(ingress.value, "protocol", null)
      to_port     = lookup(ingress.value, "to_port", null)
      cidr_blocks = lookup(ingress.value, "cidr_blocks", null)
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
  idle_timeout               = var.idle_timeout
  enable_deletion_protection = var.enable_deletion_protection
  security_groups = [
    aws_security_group.this[0].id
  ]
  subnets = var.subnets
  dynamic "access_logs" {
    for_each = var.access_logs
    content {
      bucket  = lookup(access_logs.value, "bucket", null)
      prefix  = lookup(access_logs.value, "prefix", null)
      enabled = lookup(access_logs.value, "true", null)
    }
  }
  tags = {
    Name = var.alb_name
  }
}

#------------------------------------------------------------------------------
# Create the HTTPS listener if requested
#------------------------------------------------------------------------------
resource "aws_acm_certificate" "default_cert" {
  domain_name       = "${var.alb_name}.${var.tld}"
  validation_method = "DNS"
}

resource "aws_route53_record" "default_cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.default_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  zone_id         = var.zone_id
  ttl             = 60
}

resource "aws_acm_certificate_validation" "default_validation" {
  certificate_arn         = aws_acm_certificate.default_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}


#resource "aws_acm_certificate" "default_cert" {
  #count             = var.create_https_listener ? 1 : 0
  #domain_name       = "${var.alb_name}.${var.tld}"
  #validation_method = "DNS"
#}

#resource "aws_route53_record" "default_cert_validation_record" {
  #count   = var.create_https_listener ? 1 : 0
  #name    = aws_acm_certificate.default_cert[0].domain_validation_options.0.resource_record_name
  #type    = aws_acm_certificate.default_cert[0].domain_validation_options.0.resource_record_type
  #zone_id = var.external_zone_id
  #records = [aws_acm_certificate.default_cert[0].domain_validation_options.0.resource_record_value]
  #ttl     = 60
#}

#resource "aws_acm_certificate_validation" "default_validation" {
  #count                   = var.create_https_listener ? 1 : 0
  #certificate_arn         = aws_acm_certificate.default_cert[0].arn
  #validation_record_fqdns = [aws_route53_record.default_cert_validation_record[0].fqdn]
#}

resource "aws_lb_listener" "https" {
  count             = var.create_https_listener ? 1 : 0
  load_balancer_arn = var.create_alb ? aws_lb.this[0].arn : var.load_balancer_arn
  port              = var.https_listener_port
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = aws_acm_certificate.default_cert[0].arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = var.fixed_response_content_type
      message_body = var.fixed_response_message_body
      status_code  = var.fixed_response_status_code
    }
  }
}

#------------------------------------------------------------------------------
# Create the HTTP listener
#------------------------------------------------------------------------------
resource "aws_lb_listener" "http" {
  count = var.create_http_listener ? 1 : 0

  load_balancer_arn = var.create_alb ? aws_lb.this[0].arn : var.load_balancer_arn
  port              = var.http_listener_port
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = var.fixed_response_content_type
      message_body = var.fixed_response_message_body
      status_code  = var.fixed_response_status_code
    }
  }
}

#------------------------------------------------------------------------------
# Create HTTP to HTTPS Redirect
#------------------------------------------------------------------------------
resource "aws_lb_listener" "redirect_http_to_https" {
  count = var.create_redirect_http_to_https_listener ? 1 : 0

  load_balancer_arn = var.create_alb ? aws_lb.this[0].arn : var.load_balancer_arn
  port              = var.http_listener_port
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = var.https_listener_port
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

#------------------------------------------------------------------------------
#  Create Listener Rules
#------------------------------------------------------------------------------
resource "aws_acm_certificate" "this_cert" {
  domain_name       = join(".", [var.service_name, var.tld])
  validation_method = "DNS"
}

resource "aws_route53_record" "this_cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.this_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  zone_id         = var.zone_id
  ttl             = 60
}

resource "aws_acm_certificate_validation" "this_validation" {
  certificate_arn         = aws_acm_certificate.this_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}

#resource "aws_acm_certificate" "this_cert" {
  #count       = var.create_ssl_cert ? 1 : 0
  #domain_name = join(".", [var.service_name, var.tld])
  #//domain_name       = "${var.service_name}.${var.tld}"
  #validation_method = "DNS"
#}
#
#resource "aws_route53_record" "this_cert_validation_record" {
  #count   = var.create_ssl_cert ? 1 : 0
  #name    = aws_acm_certificate.this_cert[0].domain_validation_options.0.resource_record_name
  #type    = aws_acm_certificate.this_cert[0].domain_validation_options.0.resource_record_type
  #zone_id = var.external_zone_id
  #records = [aws_acm_certificate.this_cert[0].domain_validation_options.0.resource_record_value]
  #ttl     = 60
#}
#
#resource "aws_acm_certificate_validation" "this_validation" {
  #count                   = var.create_ssl_cert ? 1 : 0
  #certificate_arn         = aws_acm_certificate.this_cert[0].arn
  #validation_record_fqdns = [aws_route53_record.this_cert_validation_record[0].fqdn]
#}

resource "aws_lb_target_group" "this" {
  count    = var.create_listener_rule ? 1 : 0
  name     = var.service_name
  port     = var.listener_rule_port
  protocol = var.listener_rule_protocol
  vpc_id   = var.vpc_id
  stickiness {
    type = "lb_cookie"
  }

  dynamic "health_check" {
    for_each = var.health_check
    content {
      interval          = lookup(health_check.value, "interval", null)
      path              = lookup(health_check.value, "path", null)
      timeout           = lookup(health_check.value, "timeout", null)
      healthy_threshold = lookup(health_check.value, "healthy_threshold", null)
      port              = lookup(health_check.value, "port", null)
      protocol          = lookup(health_check.value, "protocol", null)
      matcher           = lookup(health_check.value, "matcher", null)
    }
  }
  tags = merge(
    {
      "Name" = var.service_name
    },
    var.tags
  )
}

resource "aws_lb_listener_rule" "this" {
  count        = var.create_listener_rule ? 1 : 0
  listener_arn = var.create_https_listener ? aws_lb_listener.https[0].arn : var.listener_arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[0].arn
  }
  condition {
    field = "host-header"
    values = [
    var.create_external_r53 ? aws_route53_record.external[0].fqdn : var.external_fqdn
    ]
  }
  dynamic "condition" {
    for_each = var.condition
    content {
      field = lookup(condition.value, "field", null )
      values = lookup(condition.value, "values", null)
    }
  }
}

resource "aws_route53_record" "external" {
  count   = var.create_listener_rule && var.create_external_r53 ? 1 : 0
  name    = var.service_name
  type    = "A"
  zone_id = var.external_zone_id
  alias {
    evaluate_target_health = false
    name                   = var.create_alb ? aws_lb.this[0].dns_name : var.external_load_balancer_dns_name
    zone_id                = var.create_alb ? aws_lb.this[0].zone_id : var.external_load_balancer_zone_id
  }
}

resource "aws_route53_record" "internal" {
  count   = var.create_listener_rule && var.create_internal_r53 ? 1 : 0
  name    = var.service_name
  type    = "A"
  zone_id = var.internal_zone_id
  alias {
    evaluate_target_health = false
    name                   = var.create_alb ? aws_lb.this[0].dns_name : var.internal_load_balancer_dns_name
    zone_id                = var.create_alb ? aws_lb.this[0].zone_id : var.internal_load_balancer_zone_id
  }
}

resource "aws_lb_listener_certificate" "this" {
  depends_on = [aws_acm_certificate_validation.this_validation]
  count           = var.create_listener_rule ? 1 : 0
  certificate_arn = var.create_ssl_cert ? aws_acm_certificate.this_cert[0].arn : var.certificate_arn
  listener_arn    = var.create_https_listener ? aws_lb_listener.https[0].arn : var.listener_arn
}
