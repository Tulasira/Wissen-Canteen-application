variable "enabled" {
  type = bool
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "route_table_name" {
  description = "Name of the route table"
  type        = string
}

variable "tier" {
  description = "Tier of the route table (public/private)"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with the route table"
  type        = list(string)
}

variable "tags" {
  type = map(string)
}