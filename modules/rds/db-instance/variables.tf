variable "enabled" { type = bool }
variable "project_name" { type = string }
variable "environment" { type = string }

variable "db_subnet_group_name" { type = string }
variable "security_group_ids" { type = list(string) }
variable "parameter_group_name" { type = string }
variable "option_group_name" { type = string }

variable "db_name" { type = string }

variable "db_secret_string" {
  type      = string
  sensitive = true
}

variable "engine" { type = string }
variable "engine_version" { type = string }
variable "instance_class" { type = string }
variable "allocated_storage" { type = number }
variable "storage_type" { type = string }
variable "multi_az" { type = bool }

variable "iam_database_authentication_enabled" { type = bool }
variable "performance_insights_enabled" { type = bool }
variable "performance_insights_retention_period" { type = number }
variable "monitoring_interval" { type = number }

variable "deletion_protection" { type = bool }
variable "skip_final_snapshot" { type = bool }
variable "backup_retention_period" { type = number }
variable "preferred_backup_window" { type = string }
variable "preferred_maintenance_window" { type = string }
variable "auto_minor_version_upgrade" { type = bool }
variable "tags" { type = map(string) }

variable "monitoring_role_arn" {
  type    = string
  default = null
}