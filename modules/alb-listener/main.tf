resource "aws_lb_listener" "this" {
  load_balancer_arn = var.load_balancer_arn
  port = var.port
  protocol = var.protocol
  ssl_policy = var.ssl_policy
  certificate_arn = var.certificate_arn

    default_action {
      type = "fixed-response"

      fixed_response {
        content_type = var.content_type
        message_body = var.message_body
        status_code  = var.status_code
      }
    }
}