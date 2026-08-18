output "task_definition_arn" {
  description = "ARN of the ECS Task Definition"

  value = aws_ecs_task_definition.this[0].arn
}

output "task_definition_family" {
  description = "Task Definition family"

  value = aws_ecs_task_definition.this[0].family
}