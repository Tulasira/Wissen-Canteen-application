#########################################
# Common Variables
#########################################

variable "enabled" {
  description = "Enable or disable CloudWatch alarms"
  type        = bool
  default     = true
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
}


#########################################
# ECS Variables
#########################################

variable "cluster_name" {
  description = "ECS cluster name for CloudWatch dimensions"
  type        = string
}

variable "service_name" {
  description = "ECS service name for CloudWatch dimensions"
  type        = string
}


#########################################
# Alarm Threshold Variables
#########################################

variable "cpu_threshold" {
  description = "CPU utilization threshold percentage"
  type        = number
  default     = 80
}

variable "memory_threshold" {
  description = "Memory utilization threshold percentage"
  type        = number
  default     = 80
}


#########################################
# Tags
#########################################

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
  default     = {}
}