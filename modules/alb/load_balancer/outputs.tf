output "alb_arn" {
  value = var.enabled ? aws_lb.this[0].arn : null
}

output "alb_dns_name" {
  value = var.enabled ? aws_lb.this[0].dns_name : null
}