# terraform-aws-alb
Terraform module for creating and managing Application Load Balancers, Listeners, and Listener Rules.  It can also create internal and external Route 53 addresses for instances when you may need them, like when using an [NLB->ALB configuration](https://aws.amazon.com/blogs/networking-and-content-delivery/using-static-ip-addresses-for-application-load-balancers/)

# Usage
## Create an ALB with HTTP Redirect and an HTTPS listener that defaults to 404.
```hcl
module "application-alb" {
  source                                 = "AustinCloudGuru/alb/aws"
  version                                = "0.2.3"
  source                                 = "github.com/austincloudguru/terraform-aws-alb"
  create_alb                             = true
  alb_name                               = "test-alb"
  vpc_id                                 = "vpc-11111111111111111"
  subnets                                = ["subnet-00000000000000000", "subnet-11111111111111111", "subnet-22222222222222222"]
  create_https_listener                  = true
  tld                                    = "austincloud.guru"
  r53_zone_id                            = "Z1111111111111"
  create_redirect_http_to_https_listener = true
      security_group_ingress = [{
        from_port   = 80
        protocol    = "tcp"
        to_port     = 80
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 443
        protocol    = "tcp"
        to_port     = 443
        cidr_blocks = ["0.0.0.0/0"]
      }]
}
```

## Create a Listener Rule that attaches to an existing load balancer
```hcl
module "jenkins-alb" {
  source                 = "AustinCloudGuru/alb/aws"
  version                = "0.2.3"
  create_listener_rule   = true
  service_name           = "jenkins"
  r53_zone_id            = "Z1111111111111"
  tld                    = "austincloud.guru"
  listener_arn           = "arn:aws:elasticloadbalancing:us-east-1:111111111111:listener/app/test-alb/1111111111111111/1111111111111111"
  listener_rule_port     = 8080
  listener_rule_protocol = "HTTP"
  health_check           = [{
    interval          = 60
    path              = "/"
    timeout           = 5
    healthy_threshold = 2
    port              = 80
    matcher           = 200,201
  }]
  vpc_id                 = "vpc-11111111111111111"
  external_load_balancer_dns_name = "test-nlb-111111111111111.elb.us-east-1.amazonaws.com"
  external_load_balancer_zone_id  = "Z2222222222222"
  # Optionally, Create the internal Route 53 Address as well
  internal_load_balancer_dns_name = "internal-test-alb-111111111.us-east-1.elb.amazonaws.com"
  internal_load_balancer_zone_id  = "Z3333333333333"
}
```

## Authors
Module is maintained by [Mark Honomichl](https://github.com/austincloudguru).

## License
MIT Licensed.  See LICENSE for full details
