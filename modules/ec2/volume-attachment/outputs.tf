output "attachment_id" {
  description = "Volume Attachment ID"
  value       = try(aws_volume_attachment.this[0].id, null)
}

output "instance_id" {
  description = "Attached Instance ID"
  value       = try(aws_volume_attachment.this[0].instance_id, null)
}

output "volume_id" {
  description = "Attached Volume ID"
  value       = try(aws_volume_attachment.this[0].volume_id, null)
}