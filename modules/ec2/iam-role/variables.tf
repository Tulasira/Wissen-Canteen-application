variable "enabled" {
  type = bool
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "attach_cloudwatch_policy" {
  type    = bool
  default = true
}

variable "attach_ecr_policy" {
  type    = bool
  default = true
}

variable "attach_s3_policy" {
  type    = bool
  default = false
}

variable "tags" {
  type = map(string)
}

variable "attach_ssm_policy" {
  description = "Attach AmazonSSMManagedInstanceCore policy"
  type        = bool
  default     = true
}

variable "additional_policies" {
  description = "Additional IAM policies to attach"
  type        = list(string)
  default     = []
}