resource "aws_lb_listener" "this" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = var.content_type
      message_body = var.message_body
      status_code  = var.status_code
    }
  }
}

resource "aws_security_group_rule" "this" {
  security_group_id = var.security_group_id
  type              = "ingress"
  from_port         = var.port
  protocol          = "tcp"
  to_port           = var.port
  cidr_blocks       = var.cidr_blocks
}
