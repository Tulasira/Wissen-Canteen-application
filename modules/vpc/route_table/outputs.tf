output "route_table_id" {
  description = "ID of the route table"

  value = var.enabled ? aws_route_table.this[0].id : null
}