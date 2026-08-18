#########################################
# ECS CPU High Alarm
#########################################

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  count = var.enabled ? 1 : 0

  alarm_name          = "${var.project_name}-${var.environment}-ecs-cpu-high"
  alarm_description   = "Alarm when ECS CPU utilization is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2

  metric_name = "CPUUtilization"
  namespace   = "AWS/ECS"

  period    = 300
  statistic = "Average"
  threshold = var.cpu_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  treat_missing_data = "notBreaching"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-ecs-cpu-alarm"
    }
  )
}

#########################################
# ECS Memory High Alarm
#########################################

resource "aws_cloudwatch_metric_alarm" "ecs_memory_high" {
  count = var.enabled ? 1 : 0

  alarm_name          = "${var.project_name}-${var.environment}-ecs-memory-high"
  alarm_description   = "Alarm when ECS Memory utilization is high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2

  metric_name = "MemoryUtilization"
  namespace   = "AWS/ECS"

  period    = 300
  statistic = "Average"
  threshold = var.memory_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  treat_missing_data = "notBreaching"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-ecs-memory-alarm"
    }
  )
}