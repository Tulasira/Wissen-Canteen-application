variable "name_prefix" {
  type = string
}

variable "generated_secret_names" {
  description = "Secrets whose values Terraform generates itself (random, rotatable)."
  type        = list(string)
  default     = ["jwt_access_secret", "qr_token_secret", "mail_token_encryption_key"]
}

variable "database_url" {
  description = "Full connection string, built by the caller from the RDS module's outputs."
  type        = string
  sensitive   = true
}

variable "azure_ad_client_id" {
  type      = string
  sensitive = true
}

variable "azure_mail_client_secret" {
  type      = string
  sensitive = true
}

variable "recovery_window_days" {
  type    = number
  default = 7
}

variable "tags" {
  type    = map(string)
  default = {}
}
