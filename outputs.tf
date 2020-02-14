//output "security_group_name" {
//  value       = join("", aws_security_group.this.*.name)
//  description = "The name of the alb security group."
//}
//
//output "security_group_id" {
//  value       = join("", aws_security_group.this.*.id)
//  description = "The ID of the alb security group."
//}
//
//output "security_group_arn" {
//  value       = join("", aws_security_group.this.*.arn)
//  description = "The ARN of the alb security group."
//}
//
//output "alb_id" {
//  value       = join("", aws_lb.this.*.id)
//  description = "The ARN of the load balancer (matches arn)."
//}
//
//output "alb_arn" {
//  value       = join("", aws_lb.this.*.arn)
//  description = "The ARN of the load balancer (matches id)."
//}
//
//output "alb_arn_suffix" {
//  value       = join("", aws_lb.this.*.arn_suffix)
//  description = "The ARN suffix for use with CloudWatch Metrics."
//}
//
//output "alb_dns_name" {
//  value       = join("", aws_lb.this.*.dns_name)
//  description = "The DNS name of the load balancer."
//}
//
//output "alb_zone_id" {
//  value       = join("", aws_lb.this.*.zone_id)
//  description = "The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)."
//}
//
//output "https_alb_listener_id" {
//  value       = join("", aws_lb_listener.https.*.id)
//  description = "The ARN of the HTTPS listener (matches arn)"
//}
//
//output "https_alb_listener_arn" {
//  value       = join("", aws_lb_listener.https.*.arn)
//  description = "The ARN of the HTTPS listener (matches id)"
//}
//
//output "https_alb_listener_default_cert_arn" {
//  value       = join("", aws_acm_certificate.default_cert.*.arn)
//  description = "The ARN of the certificate"
//}
//
//output "https_alb_listener_default_cert_domain_name" {
//  value       = join("", aws_acm_certificate.default_cert.*.domain_name)
//  description = "The ARN of the certificate"
//}
//
//output "http_alb_listener_id" {
//  value       = "${join("", aws_lb_listener.http.*.id)}"
//  description = "The ARN of the HTTP listener (matches arn)"
//}
//
//output "http_alb_listener_arn" {
//  value       = "${join("", aws_lb_listener.http.*.arn)}"
//  description = "The ARN of the HTTP listener (matches id)"
//}
//
//output "redirect_http_to_https_alb_listener_id" {
//  value       = "${join("", aws_lb_listener.redirect_http_to_https.*.id)}"
//  description = "The ARN of the HTTP listener of HTTPS redirect (matches arn)"
//}
//
//output "redirect_http_to_https_alb_listener_arn" {
//  value       = "${join("", aws_lb_listener.redirect_http_to_https.*.arn)}"
//  description = "The ARN of the HTTP listener of HTTPS redirect (matches id)"
//}
//
//output "https_alb_listener_default_this_arn" {
//  value       = join("", aws_acm_certificate.this_cert.*.arn)
//  description = "The ARN of the certificate"
//}
//
//output "https_alb_listener_this_cert_domain_name" {
//  value       = join("", aws_acm_certificate.this_cert.*.domain_name)
//  description = "The ARN of the certificate"
//}
//
//output "alb_target_group_id" {
//  value       = "${join("", aws_lb_target_group.this.*.id)}"
//  description = "The ARN of the Target Group (matches arn)"
//}
//
//output "alb_target_group_arn" {
//  value       = "${join("", aws_lb_target_group.this.*.arn)}"
//  description = "The ARN of the Target Group (matches id)"
//}
//
//output "alb_target_group_arn_suffix" {
//  value       = "${join("", aws_lb_target_group.this.*.arn_suffix)}"
//  description = "The ARN suffix for use with CloudWatch Metrics."
//}
//
//output "alb_target_group_name" {
//  value       = "${join("", aws_lb_target_group.this.*.name)}"
//  description = "The name of the Target Group."
//}
//
//output "alb_target_group_port" {
//  value       = "${join("", aws_lb_target_group.this.*.port)}"
//  description = "The port of the Target Group."
//}
//
//output "alb_listener_rule_id" {
//  value       = "${join("", aws_lb_listener_rule.this.*.id)}"
//  description = "The ARN of the HTTPS rule (matches arn)"
//}
//
//output "alb_listener_rule_arn" {
//  value       = "${join("", aws_lb_listener_rule.this.*.arn)}"
//  description = "The ARN of the HTTPS rule (matches id)"
//}
//
//output "external_fqdn" {
//  value = join("", aws_route53_record.external.*.fqdn)
//  description = "The FQDN created for the external record"
//}
