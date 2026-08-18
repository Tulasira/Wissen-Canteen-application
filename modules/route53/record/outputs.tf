output "record_name" {
  description = "DNS record name"
  value       = aws_route53_record.this.name
}

output "record_fqdn" {
  description = "Fully qualified DNS record name"
  value       = aws_route53_record.this.fqdn
}
