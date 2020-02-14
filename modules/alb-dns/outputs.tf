output "name" {
  description = "The name of the record"
  value       = element(concat(aws_route53_record.this.*.name, [""]), 0)
}
output "fqdn" {
  description = " FQDN built using the zone domain and name"
  value       = element(concat(aws_route53_record.this.*.fqdn, [""]), 0)
}
