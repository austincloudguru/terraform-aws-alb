# terraform-aws-alb
Terraform module for creating and managing Application Load Balancers, Listeners, and Listener Rules.  It can also create internal and external Route 53 addresses for instances when you may need them, like when using an [NLB->ALB configuration](https://aws.amazon.com/blogs/networking-and-content-delivery/using-static-ip-addresses-for-application-load-balancers/)

# Usage
## Create an ALB with HTTP Redirect and an HTTPS listener that defaults to 404.
```hcl
module "application-alb" {
  source                                 = "AustinCloudGuru/alb/aws"
  version                                = "0.2.3"
  source                                 = "github.com/austincloudguru/terraform-aws-alb"
  create_alb                             = true
  alb_name                               = "test-alb"
  vpc_id                                 = "vpc-11111111111111111"
  subnets                                = ["subnet-00000000000000000", "subnet-11111111111111111", "subnet-22222222222222222"]
  create_https_listener                  = true
  tld                                    = "austincloud.guru"
  r53_zone_id                            = "Z1111111111111"
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

## Create a Listener Rule that attaches to an existing load balancer
```hcl
module "jenkins-alb" {
  source                 = "AustinCloudGuru/alb/aws"
  version                = "0.2.3"
  create_listener_rule   = true
  service_name           = "jenkins"
  r53_zone_id            = "Z1111111111111"
  tld                    = "austincloud.guru"
  listener_arn           = "arn:aws:elasticloadbalancing:us-east-1:111111111111:listener/app/test-alb/1111111111111111/1111111111111111"
  listener_rule_port     = 8080
  listener_rule_protocol = "HTTP"
  health_check           = [{
    interval          = 60
    path              = "/"
    timeout           = 5
    healthy_threshold = 2
    port              = 80
  }]
  vpc_id                 = "vpc-11111111111111111"
  external_load_balancer_dns_name = "test-nlb-111111111111111.elb.us-east-1.amazonaws.com"
  external_load_balancer_zone_id  = "Z2222222222222"
  # Optionally, Create the internal Route 53 Address as well
  internal_load_balancer_dns_name = "internal-test-alb-111111111.us-east-1.elb.amazonaws.com"
  internal_load_balancer_zone_id  = "Z3333333333333"
}
```

## Variables
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create_alb | Controls if the ALB should be created | bool |  false | no |
| alb_name | Name to be used for the ALB | string |  "my_alb" | no |
| vpc_id | The VPC ID | string |  "" | no |
| security_group_ingress | Can be specified multiple times for each ingress rule. | list(object({ from_port   = number protocol    = string to_port     = number cidr_blocks = list(string) })) | [{ from_port   = 443 protocol    = "tcp" to_port     = 443 cidr_blocks = ["0.0.0.0/0"] }] | no |
| access_logs | An Access Logs block" | list(object({ bucket  = string prefix  = string enabled = number })) | [] | no |
| tags | A map of tags to add to all resources | map(string) |  {} | no |
| alb_internal | If true, the LB will be internal | bool |  false | no |                        
| enable_deletion_protection | If true, deletion of the load balancer will be disabled via the AWS API | bool |  false | no |                   
| subnets | A list of subnet IDs to attach to the LB. | list(string) |  [] | no |
| create_https_listener | Controls if a listener should be created | bool |  false | no |
| load_balancer_arn | The ARN of the load balancer | string |  "" | no |
| https_listener_port | The port on which the load balancer is listening. | number |  443 | no |
| ssl_policy | The name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS. | string |  "ELBSecurityPolicy-2016-08" | no |                                                
| create_http_listener | Controls if a listener should be created | bool |  false | no |
| create_redirect_http_to_https_listener | Controls if a listener should be created | bool |  false | no |
| http_listener_port | The port on which the load balancer is listening. | number |  80 | no |
| tld | Top Level Domain to use | string |  "" | no |                                           
| external_zone_id | External zone ID for the Route R53 entry | string |  "" | no |
| create_internal_r53 | Create an internal Route54 Entry | bool | false | no |
| internal_zone_id | Internal zone ID for the Route R53 entry | string |  "" | no |
| r53_zone_id | Zone ID for the Route R53 entry | string |  "" | no |
| fixed_response_content_type | The content type. Valid values are text/plain, text/css, text/html, application/javascript and application/json. | "string" |  "text/plain" | no |              
| fixed_response_message_body | The message body. | "string" |  "404 Not Found" | no |          
| fixed_response_status_code | The HTTP response code. Valid values are 2XX, 4XX, or 5XX. | "string" |  "404" | no |
| create_listener_rule | Controls if a listener rule should be created | bool |  false | no |   
| service_name | Name of the service being deployed (used for DNS and Listener Rules) | string | "my-app" | no |       
| listener_rule_port | The port on which the listener is on. | number |  80 | no |
| listener_rule_protocol | The protocol the rule uses | string |  "HTTP" | no |                 
| health_check | Listener Rule Health Check | list(object({ interval = number path = string timeout = number healthy_threshold = number port  = number })) | [{ interval = 60 path = "/" timeout = 5 healthy_threshold = 2 port = 80 }] | no | 
| external_load_balancer_dns_name | Load balancer DNS name for the external DNS record | string |  "" | no |                         
| external_load_balancer_zone_id | Load balancer zone_id for the external DNS record | string |  "" | no |
| internal_load_balancer_dns_name | Load balancer DNS name for the internal DNS record | string |  "" | no |                         
| internal_load_balancer_zone_id | Load balancer zone_id for the internal DNS record| string |  "" | no |                           
| listener_arn | Listener Arn | string |  "" | no | 
| create_ssl_cert | Create SSL Certificate using AWS Certificate Manager | bool | true | no |
| certificate_arn | Use an existing certificate arn | string | "" | no |


## Outputs
| Name | Description |
|------|-------------|
| security_group_name | The name of the alb security group. |
| security_group_id | The ID of the alb security group. |
| security_group_arn | The ARN of the alb security group. |
| alb_id | The ARN of the load balancer (matches arn). |
| alb_arn | The ARN of the load balancer (matches id) |
| alb_arn_suffix | The ARN suffix for use with CloudWatch Metrics. |
| alb_dns_name | The DNS name of the load balancer. |
| alb_zone_id" | The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record). |
| https_alb_listener_id | The ARN of the HTTPS listener (matches arn) |
| https_alb_listener_arn | The ARN of the HTTPS listener (matches id) |
| https_alb_listener_default_cert_arn | The ARN of the certificate |
| https_alb_listener_default_cert_domain_name | The ARN of the certificate |
| http_alb_listener_id | The ARN of the HTTP listener (matches arn). |
| http_alb_listener_arn | The ARN of the HTTP listener (matches id) |
| redirect_http_to_https_alb_listener_id | The ARN of the HTTP listener of HTTPS redirect (matches arn) |
| redirect_http_to_https_alb_listener_arn | The ARN of the HTTP listener of HTTPS redirect (matches id) |
| https_alb_listener_default_this_arn | The ARN of the certificate |
| https_alb_listener_this_cert_domain_name | The ARN of the certificate |
| alb_target_group_id | The ARN of the Target Group (matches arn) |
| alb_target_group_arn | The ARN of the Target Group (matches id) |
| alb_target_group_arn_suffix | The ARN suffix for use with CloudWatch Metrics. |
| alb_target_group_name | The name of the Target Group. |
| alb_target_group_port | The port of the Target Group.|
| alb_listener_rule_id | The ARN of the HTTPS rule (matches arn) |
| alb_listener_rule_arn | The ARN of the HTTPS rule (matches id) |

## Authors
Module is maintained by [Mark Honomichl](https://github.com/austincloudguru).

## License
MIT Licensed.  See LICENSE for full details
