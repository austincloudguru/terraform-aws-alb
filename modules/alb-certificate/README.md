# acm-certificate
This module creates an ACM certificate and the necessary DNS records to Validate it.

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
| domain\_name | A domain name for which the certificate should be issued. | `string` | n/a | yes |
| zone\_id | The ID of the hosted zone to contain this record. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the certificate |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
