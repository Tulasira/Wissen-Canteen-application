variable "enabled" {
  description = "Enable or disable EC2 instance creation"
  type        = bool
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "launch_template_id" {
  description = "Launch Template ID"
  type        = string
}

variable "launch_template_version" {
  description = "Launch Template Version"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Assign Public IP"
  type        = bool
  default     = false
}

variable "disable_api_termination" {
  description = "Enable termination protection"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}