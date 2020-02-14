output "arn" {
  description = "The ARN of the certificate"
  value       = element(concat(aws_acm_certificate.this.*.arn, [""]), 0)
}
