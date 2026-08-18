output "target_group_arn" {
  description = "ARN of the Application Load Balancer Target Group"

  value = var.enabled ? aws_lb_target_group.this[0].arn : null
}

output "target_group_name" {
  description = "Name of the Application Load Balancer Target Group"

  value = var.enabled ? aws_lb_target_group.this[0].name : null
}

output "target_group_id" {
  description = "ID of the Application Load Balancer Target Group"

  value = var.enabled ? aws_lb_target_group.this[0].id : null
}