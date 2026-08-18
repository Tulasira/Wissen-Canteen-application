variable "secret_name" {
  description = "Secrets Manager secret name"
  type        = string
}

variable "secret_description" {
  description = "Secrets Manager secret description"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "password_length" {
  description = "Length of generated password"
  type        = number
}

variable "override_special" {
  description = "Allowed special characters for generated password"
  type        = string
}

variable "min_lower" {
  description = "Minimum lowercase characters"
  type        = number
}

variable "min_upper" {
  description = "Minimum uppercase characters"
  type        = number
}

variable "min_numeric" {
  description = "Minimum numeric characters"
  type        = number
}

variable "min_special" {
  description = "Minimum special characters"
  type        = number
}

variable "recovery_window_days" {
  description = "Secrets Manager recovery window in days"
  type        = number
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}