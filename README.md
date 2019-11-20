# terraform-aws-alb
Terraform module for creating and managing Application Load Balancers, Listeners, and Listener Rules.

# Usage
Create an ALB with HTTP Redirect and an HTTPS listener that defaults to 404.

```hcl
module "application-alb" {
  source                                 = "github.com/austincloudguru/terraform-aws-alb"
  create_alb                             = true
  alb_name                               = "test-alb"
  vpc_id                                 = "vpc-0156c7c6959bf4958"
  subnets                                = ["subnet-05d66d71271c33417", "subnet-0aa79b69123bb4601", "subnet-0628d803f9a448cab"]
  create_https_listener                  = true
  tld                                    = "test.cloud.fpdev.io"
  r53_zone_id                            = "Z10HFHIPPJQ56R"
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

Create Everything
```hcl
module "jenkins-alb" {
  source     = "github.com/austincloudguru/terraform-aws-alb"
  create_alb = true
  alb_name   = "test-alb"
  vpc_id     = "vpc-0156c7c6959bf4958"
  subnets    = ["subnet-05d66d71271c33417", "subnet-0aa79b69123bb4601", "subnet-0628d803f9a448cab"]
  create_https_listener = true
  tld = "test.cloud.fpdev.io"
  r53_zone_id = "Z10HFHIPPJQ56R"
  create_http_listener = false
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
  create_listener_rule = true
  service_name = "my-new-app"

}
```

listener only
```hcl
module "jenkins-alb" {
  source     = "github.com/austincloudguru/terraform-aws-alb"
  create_listener_rule = true
  service_name = "my-new-app"
  r53_zone_id = "Z10HFHIPPJQ56R"
  tld = "test.cloud.fpdev.io"
  load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-2:815424868116:loadbalancer/app/tools-application-lb/d92f495adf3100aa"
  listener_arn = "arn:aws:elasticloadbalancing:us-east-2:815424868116:listener/app/tools-application-lb/d92f495adf3100aa/3d14e37a5c372111"
  listener_rule_port = 8080
  listener_rule_protocol = "HTTP"
  health_check = [{
    interval          = 60
    path              = "/"
    timeout           = 5
    healthy_threshold = 2
    port              = 80
  }]
  vpc_id = "vpc-0156c7c6959bf4958"
  load_balancer_dns_name = "internal-tools-application-lb-982469862.us-east-2.elb.amazonaws.com"
  load_balancer_zone_id = "Z3AADJGX6KTTL2"
}
```

## Variables
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|


## Outputs

| Name | Description |
|------|-------------|


## Authors
Module is maintained by [Mark Honomichl](https://github.com/austincloudguru).

## License
MIT Licensed.  See LICENSE for full details
