variable "name" {
  description = "Name used to tag the CloudFront distribution"
  type        = string
}

variable "domain_name" {
  description = "Custom domain served by the distribution"
  type        = string
}

variable "certificate_arn" {
  description = "ARN of an ACM certificate issued in us-east-1"
  type        = string
}

variable "origin_domain_name" {
  description = "Regional domain name of the S3 origin"
  type        = string
}

variable "origin_access_control_id" {
  description = "CloudFront origin access control ID"
  type        = string
}

variable "origin_id" {
  description = "Identifier used for the distribution origin"
  type        = string
  default     = "s3-origin"
}

variable "default_root_object" {
  type    = string
  default = "index.html"
}

variable "spa_fallback" {
  type    = bool
  default = true
}

variable "price_class" {
  type    = string
  default = "PriceClass_200"
}

variable "default_ttl" {
  type    = number
  default = 3600
}

variable "max_ttl" {
  type    = number
  default = 86400
}

variable "tags" {
  type    = map(string)
  default = {}
}
