output "public_subnet_ids" {
  description = "IDs of the public subnets"

  value = var.enabled ? aws_subnet.public[*].id : []
}

output "private_app_subnet_ids" {
  description = "IDs of the private application subnets"

  value = var.enabled ? aws_subnet.private_app[*].id : []
}

output "db_subnet_ids" {
  description = "IDs of the database subnets"

  value = var.enabled ? aws_subnet.db[*].id : []
}