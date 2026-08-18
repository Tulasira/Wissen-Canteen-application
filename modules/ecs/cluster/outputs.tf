output "cluster_id" {
  description = "ID of the ECS Cluster"
  value       = aws_ecs_cluster.this[0].id
}

output "cluster_name" {
  description = "Name of the ECS Cluster"
  value       = aws_ecs_cluster.this[0].name
}

output "cluster_arn" {
  description = "ARN of the ECS Cluster"
  value       = aws_ecs_cluster.this[0].arn
}