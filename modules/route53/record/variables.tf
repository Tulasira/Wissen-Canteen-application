variable "zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
}

variable "record_name" {
  description = "DNS record name"
  type        = string
}

variable "alias_name" {
  description = "Alias target DNS name"
  type        = string
}

variable "alias_zone_id" {
  description = "Alias target hosted zone ID"
  type        = string
}

variable "evaluate_target_health" {
  description = "Evaluate target health"
  type        = bool
  default     = true
}
