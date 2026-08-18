output "db_instance_id" {
  value = aws_db_instance.this.id
}

output "db_endpoint" {
  description = "host:port"
  value       = aws_db_instance.this.endpoint
}

output "db_address" {
  description = "host only"
  value       = aws_db_instance.this.address
}

output "db_name" {
  value = aws_db_instance.this.db_name
}

output "db_username" {
  value = aws_db_instance.this.username
}

output "db_password" {
  value     = random_password.db.result
  sensitive = true
}
