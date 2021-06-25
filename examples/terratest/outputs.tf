output "url" {
  value = module.alb.alb_dns_name
}

output "tld" {
  value = data.aws_route53_zone.external.name
}

output "target_group_name" {
  value = module.alb-listener-rule.alb_target_group_name
}

output "certificate_arn" {
  value = module.alb-certificate.arn
}

output "fqdn" {
  value = module.alb-dns.fqdn
}
