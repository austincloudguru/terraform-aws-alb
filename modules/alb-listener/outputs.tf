output "listener_arn" {
  description = "The ARN of the listener"
  value       = element(concat(aws_lb_listener.this.*.arn, [""]), 0)
}
