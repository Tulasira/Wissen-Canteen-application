variable "name_prefix" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}

variable "container_image_tag" {
  type    = string
  default = "bootstrap"
}

variable "container_port" {
  type = number
}

variable "task_cpu" {
  type    = number
  default = 512
}

variable "task_memory" {
  type    = number
  default = 1024
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "target_group_arn" {
  type = string
}

variable "https_listener_arn" {
  description = "Forces the ECS service to wait until the ALB listener exists before attaching."
  type        = string
}

variable "secret_arns" {
  type = map(string)
}

variable "log_retention_days" {
  type    = number
  default = 30
}

variable "enable_autoscaling" {
  type    = bool
  default = false
}

variable "autoscaling_min_capacity" {
  type    = number
  default = 1
}

variable "autoscaling_max_capacity" {
  type    = number
  default = 4
}

variable "autoscaling_cpu_target" {
  type    = number
  default = 60
}

variable "tags" {
  type    = map(string)
  default = {}
}
