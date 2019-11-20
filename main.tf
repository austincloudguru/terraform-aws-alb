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
