resource "aws_security_group" "this" {
  count = var.enabled ? 1 : 0

  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = var.security_group_name
  })
}