variable "enabled" {
  type = bool
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "parameter_group_family" {
  type = string
}

variable "db_parameters" {
  description = "Custom DB parameter overrides. Keep empty to behave like default parameter group."
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))
  default = []
}

variable "tags" {
  type = map(string)
}