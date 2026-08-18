output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "api_url" {
  value = "https://${var.api_domain_name}"
}

output "web_url" {
  value = "https://${var.web_domain_name}"
}

output "cloudfront_distribution_id" {
  description = "Needed for cache invalidation after each web portal deploy."
  value       = module.s3_cloudfront.distribution_id
}

output "cloudfront_domain_name" {
  value = module.s3_cloudfront.distribution_domain_name
}

output "ecr_repository_url" {
  description = "Push built API images here, e.g. <url>:<git-sha>."
  value       = module.ecr.repository_url
}

output "web_s3_bucket_name" {
  description = "Sync the built Vite bundle here, e.g. `aws s3 sync dist/ s3://<bucket>/`."
  value       = module.s3_cloudfront.bucket_name
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "rds_endpoint" {
  value     = module.rds.db_endpoint
  sensitive = true
}

output "secret_arns" {
  description = "Map of logical secret name -> Secrets Manager ARN."
  value       = module.secrets.secret_arns
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "redis_endpoint" {
  value = var.enable_elasticache ? module.elasticache[0].redis_endpoint : null
}
