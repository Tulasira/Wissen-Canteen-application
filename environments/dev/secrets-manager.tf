module "secrets_manager" {
  source = "../../modules/secrets-manager"

  secret_name        = var.secret_name
  secret_description = var.secret_description

  db_username = var.db_username

  password_length      = var.password_length
  override_special     = var.override_special
  min_lower            = var.min_lower
  min_upper            = var.min_upper
  min_numeric          = var.min_numeric
  min_special          = var.min_special
  recovery_window_days = var.recovery_window_days

  tags = local.common_tags
}