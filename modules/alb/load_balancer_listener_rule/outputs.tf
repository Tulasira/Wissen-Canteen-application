output "listener_rule_arns" {
  description = "Map of listener rule ARNs"

  value = {
    for key, rule in aws_lb_listener_rule.this :
    key => rule.arn
  }
}