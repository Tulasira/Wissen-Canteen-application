variable "enabled" {
  type = bool
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string

  validation {
    condition = (
      length(var.bucket_name) >= 3 &&
      length(var.bucket_name) <= 63 &&
      can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.bucket_name)) &&
      !can(regex("^(\\d{1,3}\\.){3}\\d{1,3}$", var.bucket_name))
    )
    error_message = "Bucket name must be 3-63 characters, lowercase letters, numbers, dots, and hyphens only. It must start/end with a letter or number and must not look like an IP address."
  }
}

variable "versioning_enabled" {
  type    = bool
  default = true
}

variable "tags" {
  type = map(string)
}