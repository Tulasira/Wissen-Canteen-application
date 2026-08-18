variable "enabled" {
  description = "Enable or disable NAT Gateway creation"
  type        = bool
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID where NAT Gateway will be created"
  type        = string
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID used as dependency before NAT Gateway creation"
  type        = string
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
}