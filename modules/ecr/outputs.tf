output "repository_name" {
  description = "ECR repository name"
  value       = try(aws_ecr_repository.this[0].name, null)
}

output "repository_url" {
  description = "ECR repository URL"
  value       = try(aws_ecr_repository.this[0].repository_url, null)
}

output "repository_arn" {
  description = "ECR repository ARN"
  value       = try(aws_ecr_repository.this[0].arn, null)
}