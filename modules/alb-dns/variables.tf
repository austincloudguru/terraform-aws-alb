variable "name" {
  description = "The name of the record"
  type        = string
}

variable "zone_id" {
  description = "The ID of the hosted zone to contain this record"
  type        = string
}

variable "alias_name" {
  description = "DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone"
  type        = string
}

variable "alias_zone_id" {
  description = "Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone"
  type        = string
}
