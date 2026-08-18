variable "enabled" {
  type = bool
}

########################################################
# NACL IDs
########################################################

variable "public_nacl_id" {
  type = string
}

variable "private_app_nacl_id" {
  type = string
}

variable "db_nacl_id" {
  type = string
}

########################################################
# Public NACL Rules
########################################################

variable "public_nacl_ingress_rules" {
  type = list(object({
    rule_number = number
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "public_nacl_egress_rules" {
  type = list(object({
    rule_number = number
    cidr_block  = string
    from_port   = number
    to_port     = number
    protocol    = optional(string, "-1")
  }))
}

########################################################
# Private App NACL Rules
########################################################

variable "private_app_nacl_ingress_rules" {
  type = list(object({
    rule_number = number
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "private_app_nacl_egress_rules" {
  type = list(object({
    rule_number = number
    cidr_block  = string
    from_port   = number
    to_port     = number
    protocol    = optional(string, "-1")
  }))
}

########################################################
# Database NACL Rules
########################################################

variable "db_nacl_ingress_rules" {
  type = list(object({
    rule_number = number
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "db_nacl_egress_rules" {
  type = list(object({
    rule_number = number
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}