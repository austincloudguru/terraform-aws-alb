# alb-listener
This module creates an ALB listener with a default action that returns a fixed response (the fixed response defaults to a 404, but is configurable) and a matching ingress security group rule.

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
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_security_group_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS | `string` | `""` | no |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | List of CIDR blocks | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | The content type. Valid values are text/plain, text/css, text/html, application/javascript and application/json | `string` | `"text/plain"` | no |
| <a name="input_load_balancer_arn"></a> [load\_balancer\_arn](#input\_load\_balancer\_arn) | The ARN of the load balancer | `string` | n/a | yes |
| <a name="input_message_body"></a> [message\_body](#input\_message\_body) | The message body. | `string` | `"404 Not Found"` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the load balancer is listening | `string` | `"80"` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol for connections from clients to the load balancer | `string` | `"HTTP"` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | The security group to apply this rule to | `string` | n/a | yes |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | The name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS | `string` | `""` | no |
| <a name="input_status_code"></a> [status\_code](#input\_status\_code) | The HTTP response code. Valid values are 2XX, 4XX, or 5XX | `string` | `"404"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_listener_arn"></a> [listener\_arn](#output\_listener\_arn) | The ARN of the listener |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
