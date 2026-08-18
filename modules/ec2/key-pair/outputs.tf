output "key_name" {

  value = var.create_key_pair ? aws_key_pair.this[0].key_name : var.key_name

}

output "private_key_path" {

  value = var.create_key_pair ? local_file.private_key[0].filename : null

}

output "private_key_pem" {

  value = var.create_key_pair ? tls_private_key.this[0].private_key_pem : null

  sensitive = true

}