output "api_certificate_arn" {
  value = aws_acm_certificate_validation.api.certificate_arn
}

output "web_certificate_arn" {
  value = aws_acm_certificate_validation.web.certificate_arn
}
