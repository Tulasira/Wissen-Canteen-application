variable "domain_name" {
  description = "Domain name for the hosted zone"
  type        = string
}

variable "tags" {
  description = "Tags for the hosted zone"
  type        = map(string)
  default     = {}
}
