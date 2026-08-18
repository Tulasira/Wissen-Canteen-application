variable "enabled" {
  type = bool
}

variable "route_table_id" {
  type = string
}

variable "destination_cidr_block" {
  description = "Destination CIDR block for the route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID for public route"
  type        = string
  default     = null
}

variable "nat_gateway_id" {
  description = "NAT Gateway ID for private route"
  type        = string
  default     = null
}