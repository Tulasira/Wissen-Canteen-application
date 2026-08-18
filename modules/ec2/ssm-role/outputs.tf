output "role_name" {
  value = try(aws_iam_role.this[0].name, null)
}

output "role_arn" {
  value = try(aws_iam_role.this[0].arn, null)
}