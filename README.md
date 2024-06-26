# AWS Application Load Balancer Module
[![Terratest](https://github.com/austincloudguru/terraform-aws-alb/workflows/Terratest/badge.svg)](https://github.com/austincloudguru/terraform-aws-alb/actions?query=workflow%3ATerratest)
![Latest Version](https://img.shields.io/github/v/tag/austincloudguru/terraform-aws-alb?sort=semver&label=Latest%20Version)
[![License](https://img.shields.io/github/license/austincloudguru/terraform-aws-alb)](https://github.com/austincloudguru/terraform-aws-alb/blob/master/LICENSE)

A set of Terraform modules for working with an AWS Application Load Balancer (ALB).

Due to changes in the ACM module, you will have to choose the right tag based on your provider version.
* Version >= 1.4.0 supports AWS Provider > 3.0
* Version <= 1.0.3 supports AWS Provider ~>2.49

# Usage
`alb`:
```hcl
module "alb" {
  source                     = "AustinCloudGuru/alb/aws//module/alb"
  # You should pin the module to a specific version
  # version                   = "x.x.x"
  name                       = "production"
  vpc_id                     = "vpc-11111111111111111"
  subnets                    = ["subnet-00000000000000000", "subnet-11111111111111111", "subnet-22222222222222222"]
  internal                   = false
  enable_deletion_protection = true
  idle_timeout               = 60
  access_logs                = [{
    bucket = my-s3-bucket
    prefix = "prod-lb"
    enable = true
  }]
  tags                        = {
    Terraform = "True"
    Environment = "Production"
  }
}
```
`alb-certificate`
```hcl
module "prod-certificate" {
  source      = "AustinCloudGuru/alb/aws//modules/alb-certificate"
  # You should pin the module to a specific version
  # version                   = "x.x.x"
  domain_name = prod.austincloud.guru
  zone_id     = "Z2222222222222"
}
```

`alb-listener`:
```hcl
module "https-listener" {
  source            = "AustinCloudGuru/alb/aws//modules/alb-listener"
  # You should pin the module to a specific version
  # version                   = "x.x.x"
  load_balancer_arn = module.alb.alb_arn
  security_group_id = module.alb.security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = module.default-certificate.arn
}
```

`alb-listener-rule`
```hcl
module "my_app_listener_rule" {
  source             = "AustinCloudGuru/alb/aws//modules/alb-listener-rule"
  # You should pin the module to a specific version
  # version                   = "x.x.x"
  name               = "my-app-tg"
  port               = "443"
  protocol           = "HTTPS"
  vpc_id             = "vpc-11111111111111111"
  listener_arn       = module.https-listener.listener_arn
  attach_certificate = true
  certificate_arn    = module.my-app-certificate.arn
  host_header        = [{
    values = ["my-app.austincloud.guru"]
  }]
  health_check       = [{
    interval          = 60
    path              = "/"
    timeout           = 5
    healthy_threshold = 2
    port              = 443
    protocol          = "HTTPS"
    matcher           = 200
  }]
}
```

`alb-dns`:
```hcl
module "my_app_externall_dns" {
  source        = "AustinCloudGuru/alb/aws//modules/alb-dns"
  # You should pin the module to a specific version
  # version                   = "x.x.x"
  name          = "my-app.austincloud.guru"
  zone_id       = Z1111111111111
  alias_name    = module.alb.alb_dns_name
  alias_zone_id = module.alb.alb_zone_id
}
```

## Authors
Module is maintained by [AustinCloudGuru](https://github.com/austincloudguru).

## License
MIT Licensed.  See LICENSE for full details
