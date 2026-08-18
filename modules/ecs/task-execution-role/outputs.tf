output "task_execution_role_arn" {
  description = "ARN of the ECS Task Execution Role"

  value = aws_iam_role.this[0].arn
}

output "task_execution_role_name" {
  description = "Name of the ECS Task Execution Role"

  value = aws_iam_role.this[0].name
}