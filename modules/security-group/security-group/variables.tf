variable "enabled" {
  description = "Enable or disable security group creation"
  type        = bool
}

variable "security_group_name" {
  description = "Security group name"
  type        = string
}

variable "security_group_description" {
  description = "Security group description"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where security group will be created"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}