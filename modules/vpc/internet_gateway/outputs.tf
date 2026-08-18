output "internet_gateway_id" {
  value = var.enabled ? aws_internet_gateway.this[0].id : null
}