variable "enabled" {
  type = bool
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "option_group_engine_name" {
  type = string
}

variable "major_engine_version" {
  type = string
}

variable "db_options" {
  description = "Custom DB option overrides. Keep empty to behave like default option group."
  type = list(object({
    option_name = string
    option_settings = list(object({
      name  = string
      value = string
    }))
  }))
  default = []
}

variable "tags" {
  type = map(string)
}