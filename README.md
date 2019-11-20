# terraform-aws-alb
Terraform Module for creating and managing Application Load Balancers

```hcl
module "jenkins-alb" {
  source     = "github.com/austincloudguru/terraform-aws-alb"
  create_alb = true
  alb_name   = "test-alb"
  vpc_id     = "vpc-0156c7c6959bf4958"
  subnets    = ["subnet-05d66d71271c33417", "subnet-0aa79b69123bb4601", "subnet-0628d803f9a448cab"]
}
```