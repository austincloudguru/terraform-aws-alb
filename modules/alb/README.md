# alb
Creates an ALB.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.23 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| access\_logs | An Access Logs block | <pre>list(object({<br>    bucket  = string<br>    prefix  = string<br>    enabled = number<br>  }))</pre> | `[]` | no |
| enable\_deletion\_protection | If true, deletion of the load balancer will be disabled via the AWS API | `bool` | `false` | no |
| idle\_timeout | The time in seconds that the connection is allowed to be idle. | `number` | `60` | no |
| internal | If true, the LB will be internal | `bool` | `true` | no |
| name | The name of the LB. | `string` | `""` | no |
| subnets | A list of subnet IDs to attach to the LB. | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| vpc\_id | The VPC ID. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| alb\_arn | The ARN of the load balancer |
| alb\_arn\_suffix | The ARN suffix for use with CloudWatch Metrics |
| alb\_dns\_name | The DNS name of the load balancer |
| alb\_zone\_id | The canonical hosted zone ID of the load balancer. |
| security\_group\_arn | The ARN of the security group |
| security\_group\_id | The ID of the security group |
| security\_group\_name | The name of the security group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
