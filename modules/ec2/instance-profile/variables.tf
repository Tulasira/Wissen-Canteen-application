variable "enabled" {
  description = "Enable or disable Instance Profile creation"
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

variable "role_name" {
  description = "IAM Role name to attach"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}