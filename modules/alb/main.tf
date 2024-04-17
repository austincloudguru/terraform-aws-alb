resource "aws_security_group" "this" {
  name        = join("", [var.name, "-alb"])
  description = join(" ", ["Security Group for", var.name, "ALB"])
  vpc_id      = var.vpc_id
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.this.id
  description       = var.sg_description
  type              = "egress"
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_lb" "this" {
  #checkov:skip=CKV_AWS_150: "Ensure that Load Balancer has deletion protection enabled"
  #checkov:skip=CKV_AWS_131: "Ensure that ALB drops HTTP headers"
  #checkov:skip=CKV_AWS_103: "Ensure that load balancer is using at least TLS 1.2"
  #checkov:skip=CKV2_AWS_28: "Ensure public facing ALB are protected by WAF"
  name                       = var.name
  load_balancer_type         = "application"
  internal                   = var.internal
  idle_timeout               = var.idle_timeout
  enable_deletion_protection = var.enable_deletion_protection
  security_groups = [
    aws_security_group.this.id
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
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}
