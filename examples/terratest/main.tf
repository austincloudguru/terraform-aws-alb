#------------------------------------------------------------------------------
# Provider
#------------------------------------------------------------------------------
provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
}

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = "terratest-vpc"
  cidr               = "10.0.0.0/16"
  azs                = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Owner       = "mark"
    Environment = "terratest"
  }
}

module "alb" {
  source                     = "../../modules/alb"
  name                       = "terratest"
  vpc_id                     = module.vpc.vpc_id
  subnets                    = module.vpc.public_subnets
  internal                   = false
  enable_deletion_protection = false
  idle_timeout               = 60
  tags = {
    Owner       = "mark"
    Environment = "terratest"
  }
}

module "alb-listener" {
  source            = "../../modules/alb-listener"
  load_balancer_arn = module.alb.alb_arn
  security_group_id = module.alb.security_group_id
}

module "alb_listener_rule" {
  source       = "../../modules/alb-listener-rule"
  name         = "terratest"
  listener_arn = module.alb-listener.listener_arn
  vpc_id       = module.vpc.vpc_id
  host_header  = var.host_header
  path_pattern = var.path_pattern
}
