variable "enabled" {
  description = "Enable or disable ECS Task Execution Role creation"
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

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
}