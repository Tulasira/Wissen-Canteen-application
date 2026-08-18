resource "aws_lb_listener_rule" "this" {
  for_each = var.enabled ? var.listener_rules : {}

  listener_arn = var.listener_arns[each.value.listener_key]
  priority     = each.value.priority

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  condition {
    path_pattern {
      values = each.value.path_patterns
    }
  }
}