output "role_name" {

  value = aws_iam_role.this[0].name

}

output "role_arn" {

  value = aws_iam_role.this[0].arn

}

output "instance_profile_name" {

  value = aws_iam_instance_profile.this[0].name

}

output "instance_profile_arn" {

  value = aws_iam_instance_profile.this[0].arn

}