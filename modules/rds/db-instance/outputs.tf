output "rds_identifier" {
  value = var.enabled ? aws_db_instance.this[0].identifier : null
}

output "rds_endpoint" {
  value = var.enabled ? aws_db_instance.this[0].endpoint : null
}

output "rds_arn" {
  value = var.enabled ? aws_db_instance.this[0].arn : null
}