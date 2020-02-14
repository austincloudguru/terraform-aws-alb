output "alb_listener_rule_arn" {
  value       = element(concat(aws_lb_listener_rule.this.*.arn, [""]), 0)
  description = "The ARN of the rule."
}

output "alb_target_group_arn" {
  value       = element(concat(aws_lb_target_group.this.*.arn, [""]), 0)
  description = "The ARN of the Target Group."
}

output "alb_target_group_arn_suffix" {
  value       = element(concat(aws_lb_target_group.this.*.arn_suffix, [""]), 0)
  description = "The ARN suffix for use with CloudWatch Metrics."
}

output "alb_target_group_name" {
  value       = element(concat(aws_lb_target_group.this.*.name, [""]), 0)
  description = "The name of the Target Group."
}