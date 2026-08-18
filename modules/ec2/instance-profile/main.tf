resource "aws_iam_instance_profile" "this" {

  count = var.enabled ? 1 : 0

  name = "${var.project_name}-${var.environment}-instance-profile"

  role = var.role_name

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-instance-profile"
    }
  )
}