output "instance_profile_name" {
  description = "IAM Instance Profile Name"
  value       = try(aws_iam_instance_profile.this[0].name, null)
}

output "instance_profile_arn" {
  description = "IAM Instance Profile ARN"
  value       = try(aws_iam_instance_profile.this[0].arn, null)
}

output "instance_profile_id" {
  description = "IAM Instance Profile ID"
  value       = try(aws_iam_instance_profile.this[0].id, null)
}