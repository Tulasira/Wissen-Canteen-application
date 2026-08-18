resource "aws_ebs_volume" "this" {

  count = var.enabled ? 1 : 0

  availability_zone = var.availability_zone

  size = var.volume_size

  type = var.volume_type

  encrypted = var.encrypted

  kms_key_id = var.kms_key_id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-ebs"
    }
  )

}