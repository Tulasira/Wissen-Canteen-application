resource "aws_network_acl_rule" "public_ingress" {
  count = var.enabled ? length(var.public_nacl_ingress_rules) : 0

  network_acl_id = var.public_nacl_id
  rule_number    = var.public_nacl_ingress_rules[count.index].rule_number
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.public_nacl_ingress_rules[count.index].cidr_block
  from_port      = var.public_nacl_ingress_rules[count.index].from_port
  to_port        = var.public_nacl_ingress_rules[count.index].to_port
}

resource "aws_network_acl_rule" "public_egress" {
  count = var.enabled ? length(var.public_nacl_egress_rules) : 0

  network_acl_id = var.public_nacl_id
  rule_number    = var.public_nacl_egress_rules[count.index].rule_number
  egress         = true
  protocol       = lookup(var.public_nacl_egress_rules[count.index], "protocol", "-1")
  rule_action    = "allow"
  cidr_block     = var.public_nacl_egress_rules[count.index].cidr_block
  from_port      = var.public_nacl_egress_rules[count.index].from_port
  to_port        = var.public_nacl_egress_rules[count.index].to_port
}

########################################################
# Private App NACL Rules
########################################################

resource "aws_network_acl_rule" "private_app_ingress" {
  count = var.enabled ? length(var.private_app_nacl_ingress_rules) : 0

  network_acl_id = var.private_app_nacl_id
  rule_number    = var.private_app_nacl_ingress_rules[count.index].rule_number
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.private_app_nacl_ingress_rules[count.index].cidr_block
  from_port      = var.private_app_nacl_ingress_rules[count.index].from_port
  to_port        = var.private_app_nacl_ingress_rules[count.index].to_port
}

resource "aws_network_acl_rule" "private_app_egress" {
  count = var.enabled ? length(var.private_app_nacl_egress_rules) : 0

  network_acl_id = var.private_app_nacl_id
  rule_number    = var.private_app_nacl_egress_rules[count.index].rule_number
  egress         = true
  protocol       = lookup(var.private_app_nacl_egress_rules[count.index], "protocol", "-1")
  rule_action    = "allow"
  cidr_block     = var.private_app_nacl_egress_rules[count.index].cidr_block
  from_port      = var.private_app_nacl_egress_rules[count.index].from_port
  to_port        = var.private_app_nacl_egress_rules[count.index].to_port
}

########################################################
# Database NACL Rules
########################################################

resource "aws_network_acl_rule" "db_ingress" {
  count = var.enabled ? length(var.db_nacl_ingress_rules) : 0

  network_acl_id = var.db_nacl_id
  rule_number    = var.db_nacl_ingress_rules[count.index].rule_number
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.db_nacl_ingress_rules[count.index].cidr_block
  from_port      = var.db_nacl_ingress_rules[count.index].from_port
  to_port        = var.db_nacl_ingress_rules[count.index].to_port
}

resource "aws_network_acl_rule" "db_egress" {
  count = var.enabled ? length(var.db_nacl_egress_rules) : 0

  network_acl_id = var.db_nacl_id
  rule_number    = var.db_nacl_egress_rules[count.index].rule_number
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.db_nacl_egress_rules[count.index].cidr_block
  from_port      = var.db_nacl_egress_rules[count.index].from_port
  to_port        = var.db_nacl_egress_rules[count.index].to_port
}