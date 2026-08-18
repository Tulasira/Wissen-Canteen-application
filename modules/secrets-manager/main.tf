locals {
  common_tags = merge(var.tags, {
    Module = "secrets-manager"
  })
}

resource "random_password" "db_password" {
  length           = var.password_length
  special          = true
  override_special = var.override_special

  min_lower   = var.min_lower
  min_upper   = var.min_upper
  min_numeric = var.min_numeric
  min_special = var.min_special
}

resource "aws_secretsmanager_secret" "this" {
  name                    = var.secret_name
  description             = var.secret_description
  recovery_window_in_days = var.recovery_window_days

  tags = merge(local.common_tags, {
    Name = var.secret_name
  })
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id

  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
  })
}