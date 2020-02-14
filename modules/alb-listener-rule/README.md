# alb-listener
This module create a target group and an ALB listener rule for an already existing listener.  It currently support host_header, http_header, and path_pattern conditions.  It can also attach an additional ACM certificate if the rule needs it.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.23 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| attach\_certificate | Indicate whether a new certificate needs to be attached | `bool` | `false` | no |
| certificate\_arn | The ARN of the certificate to attach to the listener | `string` | `""` | no |
| health\_check | Listener Rule Health Check | <pre>list(object({<br>    interval          = number<br>    path              = string<br>    timeout           = number<br>    healthy_threshold = number<br>    port              = number<br>    protocol          = string<br>    matcher           = string<br>  }))</pre> | <pre>[<br>  {<br>    "healthy_threshold": 2,<br>    "interval": 60,<br>    "matcher": "200",<br>    "path": "/",<br>    "port": 80,<br>    "protocol": "HTTP",<br>    "timeout": 5<br>  }<br>]</pre> | no |
| host\_header | Contains a single value item which is a list of host header patterns to match | <pre>list(object({<br>    values = list(string)<br>  }))</pre> | `[]` | no |
| http\_header | HTTP headers to match | <pre>list(object({<br>    http_header_name = string<br>    values           = list(string)<br><br>  }))</pre> | `[]` | no |
| listener\_arn | The ARN of the listener to which to attach the rule | `string` | n/a | yes |
| name | The name of the target group | `string` | n/a | yes |
| path\_pattern | Contains a single value item which is a list of path patterns to match against the request URL | <pre>list(object({<br>    values = list(string)<br>  }))</pre> | `[]` | no |
| port | The port on which targets receive traffic, unless overridden when registering a specific target | `string` | `80` | no |
| protocol | The protocol to use for routing traffic to the targets | `string` | `"HTTP"` | no |
| stickiness | A Stickiness block | <pre>list(object({<br>    type            = string<br>    cookie_duration = number<br>  }))</pre> | <pre>[<br>  {<br>    "cookie_duration": 86400,<br>    "type": "lb_cookie"<br>  }<br>]</pre> | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| vpc\_id | The identifier of the VPC in which to create the target group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb\_listener\_rule\_arn | The ARN of the rule |
| alb\_target\_group\_arn | The ARN of the Target Group |
| alb\_target\_group\_arn\_suffix | The ARN suffix for use with CloudWatch Metrics |
| alb\_target\_group\_name | The name of the Target Group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
