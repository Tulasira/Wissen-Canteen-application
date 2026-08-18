variable "enabled" {
  description = "Enable or disable ECS Service creation"
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

variable "cluster_id" {
  description = "ECS Cluster ID"
  type        = string
}

variable "task_definition_arn" {
  description = "Task Definition ARN"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
}

variable "private_app_subnet_ids" {
  description = "Private application subnet IDs for ECS Fargate tasks"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security Group IDs attached to ECS tasks"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ALB Target Group ARN"
  type        = string
}

variable "container_name" {
  description = "Container name defined in the task definition"
  type        = string
}

variable "container_port" {
  description = "Container port exposed by the application"
  type        = number
}

variable "assign_public_ip" {
  description = "Assign public IP to Fargate tasks"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}

#########################################
# Capacity Provider
#########################################

variable "fargate_spot_percentage" {
  description = "Percentage of ECS tasks to run on FARGATE_SPOT"

  type = number

  default = 0

  validation {
    condition = (
      var.fargate_spot_percentage >= 0 &&
      var.fargate_spot_percentage <= 100
    )

    error_message = "Value must be between 0 and 100."
  }
}

variable "deployment_minimum_healthy_percent" {
  description = "Minimum healthy tasks during deployment"
  type        = number
  default     = 50
}

variable "deployment_maximum_percent" {
  description = "Maximum tasks during deployment"
  type        = number
  default     = 200
}

variable "platform_version" {
  description = "Fargate platform version"
  type        = string
  default     = "LATEST"
}

variable "health_check_grace_period_seconds" {
  description = "Grace period before ALB health checks"
  type        = number
  default     = 60
}

variable "enable_execute_command" {
  description = "Enable ECS Execute Command"
  type        = bool
  default     = true
}

variable "propagate_tags" {
  description = "Tag propagation type"
  type        = string
  default     = "SERVICE"
}