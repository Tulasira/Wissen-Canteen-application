output "ingress_cidr_rule_ids" {
  value = values(aws_security_group_rule.ingress_cidr)[*].id
}

output "ingress_security_group_rule_ids" {
  value = values(aws_security_group_rule.ingress_security_group)[*].id
}

output "egress_rule_ids" {
  value = values(aws_security_group_rule.egress)[*].id
}