output "monitoring_role_arn" {
  value = var.enabled ? aws_iam_role.this[0].arn : null
}