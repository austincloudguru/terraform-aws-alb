# alb-dns
This module creates an DNS alias record.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.23 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| alias\_name | DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone | `string` | n/a | yes |
| alias\_zone\_id | Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone | `string` | n/a | yes |
| name | The name of the record | `string` | n/a | yes |
| zone\_id | The ID of the hosted zone to contain this record | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| fqdn | FQDN built using the zone domain and name |
| name | The name of the record |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->