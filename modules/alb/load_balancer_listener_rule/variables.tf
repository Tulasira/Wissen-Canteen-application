variable "enabled" {
  type = bool
}

variable "listener_arns" {
  description = "Map of listener ARNs from listener module"
  type        = map(string)
}

variable "target_group_arn" {
  description = "Target group ARN where matching requests will be forwarded"
  type        = string
}

variable "listener_rules" {
  description = "Map of listener rules"
  type = map(object({
    listener_key  = string
    priority      = number
    path_patterns = list(string)
  }))
}