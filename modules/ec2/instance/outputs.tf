output "instance_id" {
  value = try(aws_instance.this[0].id, null)
}

output "instance_arn" {
  value = try(aws_instance.this[0].arn, null)
}

output "instance_public_ip" {
  value = try(aws_instance.this[0].public_ip, null)
}

output "instance_private_ip" {
  value = try(aws_instance.this[0].private_ip, null)
}

output "instance_state" {
  value = try(aws_instance.this[0].instance_state, null)
}

output "availability_zone" {
  value = try(aws_instance.this[0].availability_zone, null)
}