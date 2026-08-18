output "bucket_id" {
  value = var.enabled ? aws_s3_bucket.this[0].id : null
}

output "bucket_arn" {
  value = var.enabled ? aws_s3_bucket.this[0].arn : null
}

output "bucket_name" {
  value = var.enabled ? aws_s3_bucket.this[0].bucket : null
}