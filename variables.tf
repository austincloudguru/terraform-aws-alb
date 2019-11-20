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
  description = "VPC ID to deploy the ALB to"
  type        = string
  default     = ""
}

variable "security_group_ingress" {
  description = "List of Security Group Ingresses"
  type        = list(object({
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
  type        = list(object({
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
  type = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "create_http_listener" {
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

variable "fixed_response" {
  description = "An Access Logs block"
  type        = list(object({
    content_type  = string
    message_body  = string
    status_code = number
  }))
  default = [{
    content_type = "text/plain"
    message_body = "404 Not Found"
    status_code  = "404"
  }]
}

variable "r53_zone_id" {
  description = "Zone ID for the Route R53 entry"
  type = string
  default = ""
}