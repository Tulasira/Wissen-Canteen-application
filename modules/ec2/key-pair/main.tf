######################################
# Generate Private Key
######################################

resource "tls_private_key" "this" {
  count = var.enabled && var.create_key_pair ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}

######################################
# Save Private Key Locally
######################################

resource "local_file" "private_key" {
  count = var.create_key_pair && var.save_private_key ? 1 : 0

  filename        = "${path.root}/${var.key_name}.pem"
  content         = tls_private_key.this[0].private_key_pem
  file_permission = "0400"
}

######################################
# AWS Key Pair
######################################

resource "aws_key_pair" "this" {
  count = var.enabled && var.create_key_pair ? 1 : 0

  key_name   = var.key_name
  public_key = tls_private_key.this[0].public_key_openssh

  tags = merge(
    var.tags,
    {
      Name = var.key_name
    }
  )
}