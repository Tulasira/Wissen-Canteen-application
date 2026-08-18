variable "name_prefix" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "container_port" {
  description = "Port the ALB forwards to on ECS tasks; used to scope the ECS security group ingress rule."
  type        = number
}

variable "enable_elasticache_sg" {
  description = "Whether to create the ElastiCache security group (mirrors enable_elasticache upstream)."
  type        = bool
  default     = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
