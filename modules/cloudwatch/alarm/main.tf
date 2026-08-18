resource "aws_cloudwatch_metric_alarm" "this" {
  count = var.enabled ? 1 : 0

  alarm_name        = var.alarm_name
  alarm_description = var.alarm_description

  namespace   = var.namespace
  metric_name = var.metric_name

  statistic          = var.statistic
  period             = var.period
  evaluation_periods = var.evaluation_periods

  threshold           = var.threshold
  comparison_operator = var.comparison_operator

  dimensions = var.dimensions

  treat_missing_data = var.treat_missing_data

  tags = var.tags
}
