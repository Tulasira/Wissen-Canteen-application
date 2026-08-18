output "alarm_name" {
  description = "CloudWatch alarm name"
  value       = var.enabled ? aws_cloudwatch_metric_alarm.this[0].alarm_name : null
}

output "alarm_arn" {
  description = "CloudWatch alarm ARN"
  value       = var.enabled ? aws_cloudwatch_metric_alarm.this[0].arn : null
}
