output "security_group_name" {
  description = "The name of the security group"
  value       = element(concat(aws_security_group.this.*.name, [""]), 0)
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = element(concat(aws_security_group.this.*.id, [""]), 0)
}

output "security_group_arn" {
  description = "The ARN of the security group"
  value       = element(concat(aws_security_group.this.*.arn, [""]), 0)
}

output "alb_arn" {
  description = "The ARN of the load balancer"
  value       = element(concat(aws_lb.this.*.arn, [""]), 0)
}

output "alb_arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics"
  value       = element(concat(aws_lb.this.*.arn_suffix, [""]), 0)
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = element(concat(aws_lb.this.*.dns_name, [""]), 0)
}

output "alb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer"
  value       = element(concat(aws_lb.this.*.zone_id, [""]), 0)
}
