//#------------------------------------------------------------------------------
//# Create HTTP to HTTPS Redirect
//#------------------------------------------------------------------------------
//resource "aws_lb_listener" "redirect_http_to_https" {
//  count = var.create_redirect_http_to_https_listener ? 1 : 0
//
//  load_balancer_arn = var.create_alb ? aws_lb.this[0].arn : var.load_balancer_arn
//  port              = var.http_listener_port
//  protocol          = "HTTP"
//
//  default_action {
//    type = "redirect"
//
//    redirect {
//      port        = var.https_listener_port
//      protocol    = "HTTPS"
//      status_code = "HTTP_301"
//    }
//  }
//}
//
//#------------------------------------------------------------------------------
//#  Create Listener Rules
//#------------------------------------------------------------------------------
//resource "aws_lb_target_group" "this" {
//  count    = var.create_listener_rule ? 1 : 0
//  name     = var.service_name
//  port     = var.listener_rule_port
//  protocol = var.listener_rule_protocol
//  vpc_id   = var.vpc_id
//  stickiness {
//    type = "lb_cookie"
//  }
//
//  dynamic "health_check" {
//    for_each = var.health_check
//    content {
//      interval          = lookup(health_check.value, "interval", null)
//      path              = lookup(health_check.value, "path", null)
//      timeout           = lookup(health_check.value, "timeout", null)
//      healthy_threshold = lookup(health_check.value, "healthy_threshold", null)
//      port              = lookup(health_check.value, "port", null)
//      protocol          = lookup(health_check.value, "protocol", null)
//      matcher           = lookup(health_check.value, "matcher", null)
//    }
//  }
//  tags = merge(
//    {
//      "Name" = var.service_name
//    },
//    var.tags
//  )
//}
//
//resource "aws_lb_listener_rule" "this" {
//  count        = var.create_listener_rule ? 1 : 0
//  listener_arn = var.create_https_listener ? aws_lb_listener.https[0].arn : var.listener_arn
//  action {
//    type             = "forward"
//    target_group_arn = aws_lb_target_group.this[0].arn
//  }
//  condition {
//    field = "host-header"
//    values = [
//    var.create_external_r53 ? aws_route53_record.external[0].fqdn : var.external_fqdn
//    ]
//  }
//  dynamic "condition" {
//    for_each = var.condition
//    content {
//      field = lookup(condition.value, "field", null )
//      values = lookup(condition.value, "values", null)
//    }
//  }
//}
//
//resource "aws_route53_record" "external" {
//  count   = var.create_listener_rule && var.create_external_r53 ? 1 : 0
//  name    = var.service_name
//  type    = "A"
//  zone_id = var.external_zone_id
//  alias {
//    evaluate_target_health = false
//    name                   = var.create_alb ? aws_lb.this[0].dns_name : var.external_load_balancer_dns_name
//    zone_id                = var.create_alb ? aws_lb.this[0].zone_id : var.external_load_balancer_zone_id
//  }
//}
//
//resource "aws_route53_record" "internal" {
//  count   = var.create_listener_rule && var.create_internal_r53 ? 1 : 0
//  name    = var.service_name
//  type    = "A"
//  zone_id = var.internal_zone_id
//  alias {
//    evaluate_target_health = false
//    name                   = var.create_alb ? aws_lb.this[0].dns_name : var.internal_load_balancer_dns_name
//    zone_id                = var.create_alb ? aws_lb.this[0].zone_id : var.internal_load_balancer_zone_id
//  }
//}
//
//resource "aws_lb_listener_certificate" "this" {
//  depends_on = [aws_acm_certificate_validation.this_validation]
//  count           = var.create_listener_rule ? 1 : 0
//  certificate_arn = var.create_ssl_cert ? aws_acm_certificate.this_cert[0].arn : var.certificate_arn
//  listener_arn    = var.create_https_listener ? aws_lb_listener.https[0].arn : var.listener_arn
//}
