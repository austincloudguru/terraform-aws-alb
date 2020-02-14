output "listener_arn" {
  value       = element(concat(aws_lb_listener.this.*.arn, [""]), 0)
  description = "The ARN of the listener."
}
