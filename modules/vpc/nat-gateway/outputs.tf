output "nat_gateway_id" {
  value = var.enabled ? aws_nat_gateway.this[0].id : null
}

output "nat_gateway_public_ip" {
  value = var.enabled ? aws_eip.this[0].public_ip : null
}

output "nat_gateway_allocation_id" {
  value = var.enabled ? aws_eip.this[0].id : null
}