output "log_group_name" {
  description = "CloudWatch Log Group name"

  value = aws_cloudwatch_log_group.this[0].name
}

output "log_group_arn" {
  description = "CloudWatch Log Group ARN"

  value = aws_cloudwatch_log_group.this[0].arn
}