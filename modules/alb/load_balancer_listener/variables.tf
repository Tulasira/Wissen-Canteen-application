variable "enabled" {
  type = bool
}

variable "load_balancer_arn" {
  type = string
}

variable "listeners" {
  description = "Map of ALB listeners with default fixed response action"
  type = map(object({
    port                = number
    protocol            = string
    default_action_type = string
    content_type        = string
    message_body        = string
    status_code         = string
  }))
}