output "option_group_name" {
  value = var.enabled ? aws_db_option_group.this[0].name : null
}