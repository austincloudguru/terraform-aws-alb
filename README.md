# AWS Application Load Balancer Module
A set of Terraform modules for working with an AWS Application Load Balancer (ALB).

# Usage
`alb`:
```hcl
module "alb" {
  source                     = "AustinCloudGuru/alb/aws//module/alb"
  version                    = "1.0.2"
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
  version     = "1.0.2"
  domain_name = prod.austincloud.guru
  zone_id     = "Z2222222222222"
}
```

`alb-listener`:
```hcl
module "https-listener" {
  source            = "AustinCloudGuru/alb/aws//modules/alb-listener"
  version           = "1.0.2"
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
  version            = "1.0.2"
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
  version       = "1.0.2"
  name          = "my-app.austincloud.guru"
  zone_id       = Z1111111111111
  alias_name    = module.alb.alb_dns_name
  alias_zone_id = module.alb.alb_zone_id
}
```

## Authors
Module is maintained by [Mark Honomichl](https://github.com/austincloudguru).

## License
MIT Licensed.  See LICENSE for full details
