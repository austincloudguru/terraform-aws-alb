variable "name" {
  description = "The name of the LB"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "internal" {
  description = "If true, the LB will be internal"
  type        = bool
  default     = true
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API"
  type        = bool
  default     = false
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the LB"
  type        = list(string)
  default     = []
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  type        = number
  default     = 60
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
