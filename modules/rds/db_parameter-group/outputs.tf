output "parameter_group_name" {
  value = var.enabled ? aws_db_parameter_group.this[0].name : null
}