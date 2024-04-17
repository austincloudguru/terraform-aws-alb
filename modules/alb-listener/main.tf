resource "aws_lb_listener" "this" {
  #checkov:skip=CKV_AWS_2: "Ensure ALB protocol is HTTPS"
  #checkov:skip=CKV_AWS_103: "Ensure that load balancer is using at least TLS 1.2"
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
  #checkov:skip=CKV_AWS_260: "Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
  security_group_id = var.security_group_id
  description       = var.sg_description
  type              = "ingress"
  from_port         = var.port
  protocol          = "tcp"
  to_port           = var.port
  cidr_blocks       = var.cidr_blocks
}
