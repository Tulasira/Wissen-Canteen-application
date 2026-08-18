variable "enabled" {
  description = "Enable or disable security group rule creation"
  type        = bool
}

variable "security_group_id" {
  description = "Security group ID where rules will be attached"
  type        = string
}

variable "ingress_rules" {
  description = "Ingress rules for security group"
  type = list(object({
    description     = string
    port            = number
    cidr_blocks     = optional(list(string), [])
    security_groups = optional(list(string), [])
  }))
}

variable "egress_rules" {
  description = "Egress rules for security group"
  type = list(object({
    description = string
    cidr_blocks = list(string)
  }))
}