# alb-listener
This module create a target group and an ALB listener rule for an already existing listener.  It currently support host_header, http_header, and path_pattern conditions.  It can also attach an additional ACM certificate if the rule needs it.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6, < 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~>3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb_listener_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) | resource |
| [aws_lb_listener_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_certificate"></a> [attach\_certificate](#input\_attach\_certificate) | Indicate whether a new certificate needs to be attached | `bool` | `false` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The ARN of the certificate to attach to the listener | `string` | `""` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | Listener Rule Health Check | <pre>list(object({<br>    interval          = number<br>    path              = string<br>    timeout           = number<br>    healthy_threshold = number<br>    port              = number<br>    protocol          = string<br>    matcher           = string<br>  }))</pre> | <pre>[<br>  {<br>    "healthy_threshold": 2,<br>    "interval": 60,<br>    "matcher": "200",<br>    "path": "/",<br>    "port": 80,<br>    "protocol": "HTTP",<br>    "timeout": 5<br>  }<br>]</pre> | no |
| <a name="input_host_header"></a> [host\_header](#input\_host\_header) | Contains a single value item which is a list of host header patterns to match | <pre>list(object({<br>    values = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_http_header"></a> [http\_header](#input\_http\_header) | HTTP headers to match | <pre>list(object({<br>    http_header_name = string<br>    values           = list(string)<br><br>  }))</pre> | `[]` | no |
| <a name="input_listener_arn"></a> [listener\_arn](#input\_listener\_arn) | The ARN of the listener to which to attach the rule | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the target group | `string` | n/a | yes |
| <a name="input_path_pattern"></a> [path\_pattern](#input\_path\_pattern) | Contains a single value item which is a list of path patterns to match against the request URL | <pre>list(object({<br>    values = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which targets receive traffic, unless overridden when registering a specific target | `string` | `80` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol to use for routing traffic to the targets | `string` | `"HTTP"` | no |
| <a name="input_stickiness"></a> [stickiness](#input\_stickiness) | A Stickiness block | <pre>list(object({<br>    type            = string<br>    cookie_duration = number<br>  }))</pre> | <pre>[<br>  {<br>    "cookie_duration": 86400,<br>    "type": "lb_cookie"<br>  }<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The identifier of the VPC in which to create the target group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_listener_rule_arn"></a> [alb\_listener\_rule\_arn](#output\_alb\_listener\_rule\_arn) | The ARN of the rule |
| <a name="output_alb_target_group_arn"></a> [alb\_target\_group\_arn](#output\_alb\_target\_group\_arn) | The ARN of the Target Group |
| <a name="output_alb_target_group_arn_suffix"></a> [alb\_target\_group\_arn\_suffix](#output\_alb\_target\_group\_arn\_suffix) | The ARN suffix for use with CloudWatch Metrics |
| <a name="output_alb_target_group_name"></a> [alb\_target\_group\_name](#output\_alb\_target\_group\_name) | The name of the Target Group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
