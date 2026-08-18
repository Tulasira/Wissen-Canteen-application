output "launch_template_id" {

  value = try(aws_launch_template.this[0].id, null)

}

output "launch_template_name" {

  value = try(aws_launch_template.this[0].name, null)

}

output "launch_template_latest_version" {

  value = try(aws_launch_template.this[0].latest_version, null)

}