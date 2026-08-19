variable "name" {
  description = "Short identifier used in the certificate's Name tag, e.g. \"api\" or \"web\"."
  type        = string
}

variable "domain_name" {
  description = "Fully qualified domain name to issue the certificate for, e.g. api.canteen.example.com"
  type        = string
}

variable "subject_alternative_names" {
  description = "Optional extra domain names to cover with the same certificate (e.g. a bare domain + www)."
  type        = list(string)
  default     = []
}

variable "route53_zone_id" {
  description = "Hosted zone ID used to create the DNS validation record(s). The zone must already exist."
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
