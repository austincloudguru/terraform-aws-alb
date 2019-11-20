# terraform-aws-alb
Terraform Module for creating and managing Application Load Balancers, Listeners, and Listener Rules.

# Usage
Just create an ALB with HTTP Redirect and HTTPS listeners
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