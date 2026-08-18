resource "aws_ecr_repository" "this" {
  count = var.enabled ? 1 : 0

  name                 = "${var.project_name}-${var.environment}-${var.repository_name}"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  force_delete = var.force_delete

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-${var.repository_name}"
    }
  )
}