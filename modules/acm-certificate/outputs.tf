output "arn" {
  value = element(concat(aws_acm_certificate.this.*.arn, [""]), 0)
}
