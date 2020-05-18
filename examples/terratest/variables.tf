variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "host_header" {
  description = "Contains a single value item which is a list of host header patterns to match"
  type = list(object({
    values = list(string)
  }))
  default = [{
    values = ["terratest.dev.austincloud.net"]
  }]
}

variable "http_header" {
  description = "HTTP headers to match"
  type = list(object({
    http_header_name = string
    values           = list(string)

  }))
  default = []
}

variable "path_pattern" {
  description = "Contains a single value item which is a list of path patterns to match against the request URL"
  type = list(object({
    values = list(string)
  }))
  default = [{
    values = ["/api", "/apiv2"]
  }]
}
