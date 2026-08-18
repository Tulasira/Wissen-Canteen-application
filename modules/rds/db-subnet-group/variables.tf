variable "enabled" { type = bool }
variable "project_name" { type = string }
variable "environment" { type = string }
variable "db_subnet_ids" { type = list(string) }
variable "tags" { type = map(string) }