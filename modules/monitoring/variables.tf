variable "name_prefix" {
  type = string
}

variable "alarm_notification_email" {
  type    = string
  default = ""
}

variable "alb_arn_suffix" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "rds_instance_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
