output "task_role_name" {
  description = "Name of the ECS task IAM role"
  value       = aws_iam_role.task_role.name
}

output "task_role_arn" {
  description = "ARN of the ECS task IAM role"
  value       = aws_iam_role.task_role.arn
}

output "secrets_manager_policy_arn" {
  description = "ARN of the Secrets Manager IAM policy"
  value       = aws_iam_policy.secrets_manager.arn
}