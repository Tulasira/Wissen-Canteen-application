output "listener_arns" {
  description = "Map of ALB listener ARNs"

  value = {
    for key, listener in aws_lb_listener.this :
    key => listener.arn
  }
}