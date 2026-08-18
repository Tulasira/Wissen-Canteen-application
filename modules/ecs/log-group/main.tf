resource "aws_cloudwatch_log_group" "this" {
  count = var.enabled ? 1 : 0

  name = "/ecs/${var.project_name}-${var.environment}"

  retention_in_days = var.retention_in_days

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-ecs-logs"
    }
  )
}