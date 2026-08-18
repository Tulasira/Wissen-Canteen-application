output "volume_id" {
  value = try(aws_ebs_volume.this[0].id, null)
}

output "volume_arn" {
  value = try(aws_ebs_volume.this[0].arn, null)
}

output "availability_zone" {
  value = try(aws_ebs_volume.this[0].availability_zone, null)
}