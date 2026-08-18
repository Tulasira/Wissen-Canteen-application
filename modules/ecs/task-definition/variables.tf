variable "enabled" {
  description = "Enable or disable Task Definition creation"
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

variable "task_execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  type        = string
}

variable "task_role_arn" {
  description = "Task Role ARN"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_image" {
  description = "Container image"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "cpu" {
  description = "Task CPU"
  type        = number
}

variable "memory" {
  description = "Task Memory"
  type        = number
}

variable "log_group_name" {
  description = "CloudWatch Log Group Name"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
}

#########################################
# Runtime Platform
#########################################

variable "operating_system_family" {
  description = "Operating System Family"
  type        = string
  default     = "LINUX"
}

variable "cpu_architecture" {
  description = "CPU Architecture"
  type        = string
  default     = "X86_64"
}

#########################################
# Environment Variables
#########################################

variable "environment_variables" {
  description = "Container Environment Variables"

  type = list(object({
    name  = string
    value = string
  }))

  default = []
}

#########################################
# Secrets Manager
#########################################

variable "container_secrets" {
  description = "Secrets injected from Secrets Manager"

  type = list(object({
    name      = string
    valueFrom = string
  }))

  default = []
}

#########################################
# ECS Health Check
#########################################

variable "ecs_health_check_enabled" {
  description = "Enable ECS Container Health Check"
  type        = bool
  default     = true
}

variable "ecs_health_check_command" {
  description = "Health Check Command"

  type = list(string)

  default = [
    "CMD-SHELL",
    "curl -f http://localhost/ || exit 1"
  ]
}

variable "ecs_health_check_interval" {
  description = "Health Check Interval"
  type        = number
  default     = 30
}

variable "ecs_health_check_timeout" {
  description = "Health Check Timeout"
  type        = number
  default     = 5
}

variable "ecs_health_check_retries" {
  description = "Health Check Retries"
  type        = number
  default     = 3
}

variable "ecs_health_check_start_period" {
  description = "Health Check Start Period"
  type        = number
  default     = 60
}

#########################################
# Container Security
#########################################

variable "readonly_root_filesystem" {
  description = "Enable read only root filesystem"
  type        = bool
  default     = true
}

#########################################
# Linux Parameters
#########################################

variable "linux_init_process_enabled" {
  description = "Enable init process inside container"
  type        = bool
  default     = true
}