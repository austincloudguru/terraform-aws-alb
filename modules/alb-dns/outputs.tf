output "name" {
  value = element(concat(aws_route53_record.this.*.name, [""]), 0)
  description = "The name of the record."
}
output "fqdn" {
  value = element(concat(aws_route53_record.this.*.fqdn, [""]), 0)
  description = " FQDN built using the zone domain and name."
}