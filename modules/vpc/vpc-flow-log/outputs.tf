output "flow_log_id" {
  value = var.enabled ? aws_flow_log.this[0].id : null
}

output "flow_log_group_name" {
  value = var.enabled ? aws_cloudwatch_log_group.this[0].name : null
}

output "flow_log_role_arn" {
  value = var.enabled ? aws_iam_role.this[0].arn : null
}