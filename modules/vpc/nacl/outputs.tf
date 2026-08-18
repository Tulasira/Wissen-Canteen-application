output "public_nacl_id" {
  description = "ID of the Public Network ACL"

  value = var.enabled ? aws_network_acl.public[0].id : null
}

output "private_app_nacl_id" {
  description = "ID of the Private Application Network ACL"

  value = var.enabled ? aws_network_acl.private_app[0].id : null
}

output "db_nacl_id" {
  description = "ID of the Database Network ACL"

  value = var.enabled ? aws_network_acl.db[0].id : null
}