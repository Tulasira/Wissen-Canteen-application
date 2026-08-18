variable "enabled" {
  type = bool
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "internal" {
  description = "Creates an internal ALB when true, or an internet-facing ALB when false."
  type        = bool
}

variable "enable_deletion_protection" {
  type = bool
}

variable "tags" {
  type = map(string)
}