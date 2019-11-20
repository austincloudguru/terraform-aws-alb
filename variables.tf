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
}

variable "access_logs" {
  description = "An Access Logs block"
  type        = object({
    bucket  = string
    prefix  = string
    enabled = number
  })
  default = {}
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
