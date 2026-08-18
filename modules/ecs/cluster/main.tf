resource "aws_ecs_cluster" "this" {
  count = var.enabled ? 1 : 0

  name = "${var.project_name}-${var.environment}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = var.container_insights_enabled ? "enabled" : "disabled"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-ecs-cluster"
    }
  )
}