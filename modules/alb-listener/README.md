# alb-listener
This module creates an ALB listener with a default action that returns a fixed response (the fixed response defaults to a 404, but is configurable) and a matching ingress security group rule.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6, < 0.14 |
| aws | ~>3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~>3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| certificate\_arn | The ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS | `string` | `""` | no |
| cidr\_blocks | List of CIDR blocks | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| content\_type | The content type. Valid values are text/plain, text/css, text/html, application/javascript and application/json | `string` | `"text/plain"` | no |
| load\_balancer\_arn | The ARN of the load balancer | `string` | n/a | yes |
| message\_body | The message body. | `string` | `"404 Not Found"` | no |
| port | The port on which the load balancer is listening | `string` | `"80"` | no |
| protocol | The protocol for connections from clients to the load balancer | `string` | `"HTTP"` | no |
| security\_group\_id | The security group to apply this rule to | `string` | n/a | yes |
| ssl\_policy | The name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS | `string` | `""` | no |
| status\_code | The HTTP response code. Valid values are 2XX, 4XX, or 5XX | `string` | `"404"` | no |

## Outputs

| Name | Description |
|------|-------------|
| listener\_arn | The ARN of the listener |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
