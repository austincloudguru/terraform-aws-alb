variable "load_balancer_arn" {
  description = "The ARN of the load balancer"
  type        = string
}

variable "port" {
  description = "The port on which the load balancer is listening"
  type        = string
  default     = "80"
}

variable "protocol" {
  description = "The protocol for connections from clients to the load balancer"
  type        = string
  default     = "HTTP"
}

variable "ssl_policy" {
  description = "The name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "The ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS"
  type        = string
  default     = ""
}

variable "content_type" {
  description = "The content type. Valid values are text/plain, text/css, text/html, application/javascript and application/json"
  type        = string
  default     = "text/plain"
}

variable "message_body" {
  description = "The message body."
  type        = string
  default     = "404 Not Found"
}

variable "status_code" {
  description = "The HTTP response code. Valid values are 2XX, 4XX, or 5XX"
  type        = string
  default     = "404"
}

variable "security_group_id" {
  description = "The security group to apply this rule to"
  type        = string
}

variable "cidr_blocks" {
  description = "List of CIDR blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
