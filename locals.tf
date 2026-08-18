locals {
  common_tags = merge(var.tags, {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  })

  name_prefix = "${var.project_name}-${var.environment}"

  generated_secret_names = [
    "jwt_access_secret",
    "qr_token_secret",
    "mail_token_encryption_key",
  ]

  database_url = "postgresql://${module.rds.db_username}:${module.rds.db_password}@${module.rds.db_address}:5432/${module.rds.db_name}?schema=public"
}
