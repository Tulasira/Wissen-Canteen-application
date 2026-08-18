output "service_name" {
  description = "ECS Service Name"
  value       = try(aws_ecs_service.this[0].name, null)
}

output "service_arn" {
  description = "ECS Service ARN"
  value       = try(aws_ecs_service.this[0].id, null)
}