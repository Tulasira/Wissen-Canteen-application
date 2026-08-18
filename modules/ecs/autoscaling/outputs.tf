#########################################
# ECS Auto Scaling Target
#########################################

output "resource_id" {
  description = "ECS Auto Scaling Resource ID"

  value = (
    var.enabled
    ? aws_appautoscaling_target.this[0].resource_id
    : null
  )
}

#########################################
# CPU Scaling Policy ARN
#########################################

output "cpu_scaling_policy_arn" {
  description = "CPU Scaling Policy ARN"

  value = (
    var.enabled
    ? aws_appautoscaling_policy.cpu[0].arn
    : null
  )
}

#########################################
# Memory Scaling Policy ARN
#########################################

output "memory_scaling_policy_arn" {
  description = "Memory Scaling Policy ARN"

  value = (
    var.enabled
    ? aws_appautoscaling_policy.memory[0].arn
    : null
  )
}