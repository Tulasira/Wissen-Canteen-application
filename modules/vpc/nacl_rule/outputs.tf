output "public_ingress_rule_ids" {
  value = aws_network_acl_rule.public_ingress[*].id
}

output "public_egress_rule_ids" {
  value = aws_network_acl_rule.public_egress[*].id
}

output "private_app_ingress_rule_ids" {
  value = aws_network_acl_rule.private_app_ingress[*].id
}

output "private_app_egress_rule_ids" {
  value = aws_network_acl_rule.private_app_egress[*].id
}

output "db_ingress_rule_ids" {
  value = aws_network_acl_rule.db_ingress[*].id
}

output "db_egress_rule_ids" {
  value = aws_network_acl_rule.db_egress[*].id
}