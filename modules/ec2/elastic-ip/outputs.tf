output "allocation_id" {
  description = "Elastic IP Allocation ID"
  value       = try(aws_eip.this[0].allocation_id, null)
}

output "association_id" {
  description = "Elastic IP Association ID"
  value       = try(aws_eip.this[0].association_id, null)
}

output "public_ip" {
  description = "Elastic IP Address"
  value       = try(aws_eip.this[0].public_ip, null)
}

output "public_dns" {
  description = "Public DNS"
  value       = try(aws_eip.this[0].public_dns, null)
}