output "certificate_arn" {
  description = "ARN of the validated certificate — safe to use immediately in an ALB listener or CloudFront distribution."
  value       = aws_acm_certificate_validation.this.certificate_arn
}

output "certificate_domain_name" {
  value = aws_acm_certificate.this.domain_name
}
