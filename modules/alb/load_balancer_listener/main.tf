resource "aws_lb_listener" "this" {
  for_each = var.enabled ? var.listeners : {}

  load_balancer_arn = var.load_balancer_arn
  port              = each.value.port
  protocol          = each.value.protocol

  default_action {
    type = each.value.default_action_type

    fixed_response {
      content_type = each.value.content_type
      message_body = each.value.message_body
      status_code  = each.value.status_code
    }
  }
}