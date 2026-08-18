#########################################
# General
#########################################

variable "enabled" {
  description = "Enable or disable ECS Auto Scaling"
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

#########################################
# ECS
#########################################

variable "cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "service_name" {
  description = "ECS Service Name"
  type        = string
}

#########################################
# Capacity
#########################################

variable "min_capacity" {
  description = "Minimum number of ECS tasks"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of ECS tasks"
  type        = number
}

#########################################
# CPU Scaling
#########################################

variable "cpu_target_value" {
  description = "Target CPU utilization percentage"
  type        = number
}

#########################################
# Memory Scaling
#########################################

variable "memory_target_value" {
  description = "Target Memory utilization percentage"
  type        = number
}

#########################################
# Cooldown
#########################################

variable "scale_in_cooldown" {
  description = "Cooldown period after scale in"
  type        = number
}

variable "scale_out_cooldown" {
  description = "Cooldown period after scale out"
  type        = number
}