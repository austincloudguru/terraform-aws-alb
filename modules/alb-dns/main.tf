resource "aws_route53_record" "this" {
  name    = var.name
  type    = "A"
  zone_id = var.zone_id
  alias {
    evaluate_target_health = false
    name                   = var.alias_name
    zone_id                = var.alias_zone_id
  }
}
