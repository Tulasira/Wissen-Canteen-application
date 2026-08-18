variable "enabled" {
  description = "Enable or disable the CloudWatch alarm"
  type        = bool
  default     = true
}

variable "alarm_name" {
  description = "CloudWatch alarm name"
  type        = string
}

variable "alarm_description" {
  description = "CloudWatch alarm description"
  type        = string
  default     = null
}

variable "namespace" {
  description = "CloudWatch metric namespace"
  type        = string
}

variable "metric_name" {
  description = "CloudWatch metric name"
  type        = string
}

variable "statistic" {
  description = "CloudWatch statistic"
  type        = string
  default     = "Average"
}

variable "period" {
  description = "Metric period in seconds"
  type        = number
  default     = 300
}

variable "evaluation_periods" {
  description = "Number of evaluation periods"
  type        = number
  default     = 2
}

variable "threshold" {
  description = "Alarm threshold"
  type        = number
}

variable "comparison_operator" {
  description = "CloudWatch comparison operator"
  type        = string
}

variable "dimensions" {
  description = "CloudWatch metric dimensions"
  type        = map(string)
  default     = {}
}

variable "treat_missing_data" {
  description = "How missing data is treated"
  type        = string
  default     = "notBreaching"
}

variable "tags" {
  description = "Tags for the alarm"
  type        = map(string)
  default     = {}
}
