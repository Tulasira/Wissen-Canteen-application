module "cloudwatch_alarm" {
  source = "../../modules/cloudwatch/alarm"

  enabled = true

  alarm_name        = "${var.project_name}-${var.environment}-cloudwatch-alarm"
  alarm_description = "CloudWatch monitoring alarm for the application"

  namespace   = "AWS/ApplicationELB"
  metric_name = "HTTPCode_ELB_5XX_Count"

  statistic          = "Sum"
  period             = 300
  evaluation_periods = 2

  threshold           = 5
  comparison_operator = "GreaterThanThreshold"

  dimensions = {}

  treat_missing_data = "notBreaching"

  tags = local.common_tags
}
