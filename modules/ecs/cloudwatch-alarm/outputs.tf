#########################################
# ECS CPU Alarm Outputs
#########################################

output "ecs_cpu_alarm_name" {
  description = "Name of the ECS CPU high CloudWatch alarm"
  value       = var.enabled ? aws_cloudwatch_metric_alarm.ecs_cpu_high[0].alarm_name : null
}

output "ecs_cpu_alarm_arn" {
  description = "ARN of the ECS CPU high CloudWatch alarm"
  value       = var.enabled ? aws_cloudwatch_metric_alarm.ecs_cpu_high[0].arn : null
}


#########################################
# ECS Memory Alarm Outputs
#########################################

output "ecs_memory_alarm_name" {
  description = "Name of the ECS Memory high CloudWatch alarm"
  value       = var.enabled ? aws_cloudwatch_metric_alarm.ecs_memory_high[0].alarm_name : null
}

output "ecs_memory_alarm_arn" {
  description = "ARN of the ECS Memory high CloudWatch alarm"
  value       = var.enabled ? aws_cloudwatch_metric_alarm.ecs_memory_high[0].arn : null
}