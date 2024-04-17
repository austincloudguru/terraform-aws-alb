#------------------------------------------------------------------------------
# Provider
#------------------------------------------------------------------------------
provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

data "aws_route53_zone" "external" {
  name = join("", [var.tld, "."])
}

module "vpc" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source             = "terraform-aws-modules/vpc/aws"
  name               = "terratest-vpc"
  cidr               = "10.0.0.0/16"
  azs                = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  tags               = var.tags
}

module "alb" {
  source                     = "../../modules/alb"
  name                       = "terratest"
  vpc_id                     = module.vpc.vpc_id
  subnets                    = module.vpc.public_subnets
  internal                   = false
  enable_deletion_protection = false
  idle_timeout               = 60
  tags                       = var.tags
}

module "alb-listener" {
  source            = "../../modules/alb-listener"
  load_balancer_arn = module.alb.alb_arn
  security_group_id = module.alb.security_group_id
}

module "alb-listener-certificate" {
  source      = "../../modules/alb-certificate"
  domain_name = join(".", ["terratest-alb", data.aws_route53_zone.external.name])
  zone_id     = data.aws_route53_zone.external.zone_id
}

module "alb-certificate" {
  source      = "../../modules/alb-certificate"
  domain_name = join(".", ["terratest", data.aws_route53_zone.external.name])
  zone_id     = data.aws_route53_zone.external.zone_id
}

module "alb-dns" {
  source        = "../../modules/alb-dns"
  name          = "terratest"
  zone_id       = data.aws_route53_zone.external.zone_id
  alias_name    = module.alb.alb_dns_name
  alias_zone_id = module.alb.alb_zone_id
}

module "alb-listener-https" {
  source            = "../../modules/alb-listener"
  load_balancer_arn = module.alb.alb_arn
  security_group_id = module.alb.security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = module.alb-listener-certificate.arn
}

module "alb-listener-rule" {
  source             = "../../modules/alb-listener-rule"
  name               = "terratest"
  port               = "443"
  protocol           = "HTTPS"
  vpc_id             = module.vpc.vpc_id
  listener_arn       = module.alb-listener-https.listener_arn
  attach_certificate = true
  certificate_arn    = module.alb-certificate.arn
  host_header        = [{ values = [join(".", ["terratest", var.tld])] }]
  health_check = [{
    interval          = 60
    path              = "/"
    timeout           = 5
    healthy_threshold = 2
    port              = 80
    protocol          = "HTTP"
    matcher           = 200
  }]
}
