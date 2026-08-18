variable "name_prefix" {
  type = string
}

variable "account_id" {
  type = string
}

variable "web_domain_name" {
  type = string
}

variable "web_certificate_arn" {
  description = "Must be an ACM certificate issued in us-east-1."
  type        = string
}

variable "price_class" {
  type    = string
  default = "PriceClass_200"
}

variable "tags" {
  type    = map(string)
  default = {}
}
