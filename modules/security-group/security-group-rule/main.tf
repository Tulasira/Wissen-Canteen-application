resource "aws_security_group_rule" "ingress_cidr" {
  for_each = var.enabled ? {
    for index, rule in var.ingress_rules : index => rule
    if length(lookup(rule, "cidr_blocks", [])) > 0
  } : {}

  type              = "ingress"
  security_group_id = var.security_group_id

  description = each.value.description
  from_port   = each.value.port
  to_port     = each.value.port
  protocol    = "tcp"
  cidr_blocks = each.value.cidr_blocks
}

resource "aws_security_group_rule" "ingress_security_group" {
  for_each = var.enabled ? {
    for index, rule in var.ingress_rules : index => rule
    if length(lookup(rule, "security_groups", [])) > 0
  } : {}

  type                     = "ingress"
  security_group_id        = var.security_group_id
  source_security_group_id = each.value.security_groups[0]

  description = each.value.description
  from_port   = each.value.port
  to_port     = each.value.port
  protocol    = "tcp"
}

resource "aws_security_group_rule" "egress" {
  for_each = var.enabled ? {
    for index, rule in var.egress_rules : index => rule
  } : {}

  type              = "egress"
  security_group_id = var.security_group_id

  description = each.value.description
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = each.value.cidr_blocks
}