variable "enabled" {
  type = bool
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "target_group_port" {
  type = number
}

variable "target_group_protocol" {
  description = "Protocol used by the target group"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  type = string
}

variable "health_check_enabled" {
  description = "Enable or disable target group health check"
  type        = bool
  default     = true
}

variable "health_check_path" {
  type = string
}

variable "health_check_protocol" {
  description = "Protocol used for health check"
  type        = string
  default     = "HTTP"
}

variable "health_check_matcher" {
  description = "Expected HTTP response code for health check"
  type        = string
  default     = "200"
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of successful health checks before target is healthy"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Number of failed health checks before target is unhealthy"
  type        = number
  default     = 3
}

variable "tags" {
  type = map(string)
}