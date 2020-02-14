resource "aws_lb_target_group" "this" {
  name     = var.name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  dynamic "stickiness" {
    for_each = var.stickiness
    content {
      type = lookup(stickiness.value, "type", null)
      cookie_duration = lookup(stickiness.value, "cookie_duration", null)
    }
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
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    dynamic "host_header" {
      for_each = var.host_header
      content {
        values = lookup(host_header.value, "values", null )
      }
    }
    dynamic "http_header" {
      for_each = var.http_header
      content {
        http_header_name = lookup(http_header.value, "http_header_name", null)
        values = lookup(http_header.value, "values", null)
      }
    }
  }
}

resource "aws_lb_listener_certificate" "this" {
  count = var.certificate_arn ? 1 : 0
  certificate_arn = var.certificate_arn
  listener_arn    = var.listener_arn
}
