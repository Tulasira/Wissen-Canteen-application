output "route_id" {
  description = "ID of the created route"

  value = var.enabled ? aws_route.this[0].id : null
}