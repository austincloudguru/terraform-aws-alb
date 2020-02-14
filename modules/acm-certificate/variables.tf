variable "domain_name" {
  description = "A domain name for which the certificate should be issued."
  type        = string
}

variable "zone_id" {
  description = "The ID of the hosted zone to contain this record."
  type        = string
}
