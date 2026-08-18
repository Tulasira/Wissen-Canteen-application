resource "aws_eip" "this" {

  count = var.enabled ? 1 : 0

  domain = "vpc"

  instance = var.associate_with_instance ? var.instance_id : null

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-eip"
    }
  )

}