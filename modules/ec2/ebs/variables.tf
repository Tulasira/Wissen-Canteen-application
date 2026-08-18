variable "enabled" {
  description = "Enable or disable EBS volume creation"
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

variable "availability_zone" {
  description = "Availability Zone for the EBS volume"
  type        = string
}

variable "volume_size" {
  description = "Volume size in GB"
  type        = number
}

variable "volume_type" {
  description = "EBS volume type"
  type        = string
  default     = "gp3"
}

variable "encrypted" {
  description = "Enable encryption"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS Key ID (optional)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}