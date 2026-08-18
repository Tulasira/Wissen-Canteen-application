output "alb_arn" {
  value = aws_lb.api.arn
}

output "alb_arn_suffix" {
  value = aws_lb.api.arn_suffix
}

output "alb_dns_name" {
  value = aws_lb.api.dns_name
}

output "alb_zone_id" {
  value = aws_lb.api.zone_id
}

output "target_group_arn" {
  value = aws_lb_target_group.api.arn
}

output "https_listener_arn" {
  value = aws_lb_listener.https.arn
}
