variable "enabled" {
  description = "Enable or disable Elastic IP creation"
  type        = bool
}

variable "instance_id" {
  description = "EC2 Instance ID"
  type        = string
}

variable "associate_with_instance" {
  description = "Whether to associate EIP with EC2"
  type        = bool
  default     = true
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}