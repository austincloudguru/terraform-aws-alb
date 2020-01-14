variable "create_alb" {
  description = "Controls if the ALB should be created"
  type        = bool
  default     = false
}

variable "alb_name" {
  description = "Name to be used for the ALB"
  type        = string
  default     = "my_alb"
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  default     = ""
}

variable "security_group_ingress" {
  description = "Can be specified multiple times for each ingress rule. "
  type = list(object({
    from_port   = number
    protocol    = string
    to_port     = number
    cidr_blocks = list(string)
  }))
  default = [{
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

variable "access_logs" {
  description = "An Access Logs block"
  type = list(object({
    bucket  = string
    prefix  = string
    enabled = number
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "alb_internal" {
  description = "If true, the LB will be internal"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API"
  type        = bool
  default     = false
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the LB."
  type        = list(string)
  default     = []
}

variable "create_https_listener" {
  description = "Controls if a listener should be created"
  type        = bool
  default     = false
}

variable "load_balancer_arn" {
  description = "The ARN of the load balancer"
  type        = string
  default     = ""
}

variable "https_listener_port" {
  description = "The port on which the load balancer is listening."
  type        = number
  default     = 443
}

variable "ssl_policy" {
  description = "The name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS."
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "create_http_listener" {
  description = "Controls if a listener should be created"
  type        = bool
  default     = false
}

variable "create_redirect_http_to_https_listener" {
  description = "Controls if a listener should be created"
  type        = bool
  default     = false
}

variable "http_listener_port" {
  description = "The port on which the load balancer is listening."
  type        = number
  default     = 80
}

variable "tld" {
  description = "Top Level Domain to use"
  type        = string
  default     = ""
}

variable "external_zone_id" {
  description = "External zone ID for the Route R53 entry"
  type        = string
  default     = ""
}

variable "create_internal_r53" {
  description = "Create an internal Route54 Entry"
  type        = bool
  default     = false
}

variable "create_external_r53" {
  description = "Create an external Route53 Entry"
  type        = bool
  default     = true
}

variable "external_fqdn" {
  description = "The FQDN if you are not creating a Route 53 Record"
  type        = string
  default     = ""
}

variable "internal_zone_id" {
  description = "Internal zone ID for the Route R53 entry"
  type        = string
  default     = ""
}

variable "fixed_response_content_type" {
  description = "The content type. Valid values are text/plain, text/css, text/html, application/javascript and application/json."
  type        = "string"
  default     = "text/plain"
}

variable "fixed_response_message_body" {
  description = "The message body."
  type        = "string"
  default     = "404 Not Found"
}

variable "fixed_response_status_code" {
  description = "The HTTP response code. Valid values are 2XX, 4XX, or 5XX."
  type        = "string"
  default     = "404"
}

variable "create_listener_rule" {
  description = "Controls if a listener rule should be created"
  type        = bool
  default     = false
}

variable "service_name" {
  description = "Name of the service being deployed (used for DNS and Listener Rules)"
  type        = string
  default     = "my-app"
}

variable "listener_rule_port" {
  description = "The port on which the listener is on."
  type        = number
  default     = 80
}

variable "listener_rule_protocol" {
  description = "The protocol the rule uses"
  type        = string
  default     = "HTTP"
}

variable "health_check" {
  description = "Listener Rule Health Check"
  type = list(object({
    interval          = number
    path              = string
    timeout           = number
    healthy_threshold = number
    port              = number
    protocol          = string
    matcher           = string
  }))
  default = [{
    interval          = 60
    path              = "/"
    timeout           = 5
    healthy_threshold = 2
    port              = 80
    protocol          = "HTTP"
    matcher           = "200"
  }]
}

variable "external_load_balancer_dns_name" {
  description = "Load balancer DNS name for the external DNS record"
  type        = string
  default     = ""
}

variable "external_load_balancer_zone_id" {
  description = "Load balancer zone_id for the external DNS record"
  type        = string
  default     = ""
}

variable "internal_load_balancer_dns_name" {
  description = "Load balancer DNS name for the internal DNS record"
  type        = string
  default     = ""
}

variable "internal_load_balancer_zone_id" {
  description = "Load balancer zone_id for the internal DNS record"
  type        = string
  default     = ""
}

variable "listener_arn" {
  description = "Listener Arn"
  type        = string
  default     = ""
}

variable "create_ssl_cert" {
  description = "Create SSL Certificate using AWS Certificate Manager"
  type        = bool
  default     = true
}

variable "certificate_arn" {
  description = "Use an Existing Certificate Arn"
  type        = string
  default     = ""
}
variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle. "
  type        = number
  default     = 60
}

variable "condition" {
  description = "An Access Logs block"
  type = list(object({
    field  = string
    values  = list(string)
  }))
  default = []
}
