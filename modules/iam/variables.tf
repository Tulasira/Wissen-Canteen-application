variable "role_name" {
  description = "Name of the ECS task IAM role"
  type        = string
}

variable "policy_name" {
  description = "Name of the Secrets Manager IAM policy"
  type        = string
}

variable "secret_arn" {
  description = "ARN of the Secrets Manager secret"
  type        = string
}

variable "tags" {
  description = "Tags for IAM resources"
  type        = map(string)
  default     = {}
}