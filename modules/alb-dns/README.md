# alb-dns
This module creates an DNS alias record.

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
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias_name"></a> [alias\_name](#input\_alias\_name) | DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone | `string` | n/a | yes |
| <a name="input_alias_zone_id"></a> [alias\_zone\_id](#input\_alias\_zone\_id) | Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the record | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The ID of the hosted zone to contain this record | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | FQDN built using the zone domain and name |
| <a name="output_name"></a> [name](#output\_name) | The name of the record |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
