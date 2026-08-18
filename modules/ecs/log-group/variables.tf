variable "enabled" {
  description = "Enable or disable CloudWatch Log Group creation"
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

variable "retention_in_days" {
  description = "CloudWatch log retention period"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
}