output "security_group_id" {
  value = var.enabled ? aws_security_group.this[0].id : null
}

output "security_group_name" {
  value = var.enabled ? aws_security_group.this[0].name : null
}