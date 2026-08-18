variable "name_prefix" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "api_domain_name" {
  type = string
}

variable "web_domain_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
