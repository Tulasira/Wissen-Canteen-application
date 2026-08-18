terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

# Every secret the API needs at runtime lives here and is injected into the
# ECS task definition as an environment variable via `secrets` (never baked
# into the container image). See modules/ecs for how these are wired in.

resource "random_password" "generated" {
  for_each = toset(var.generated_secret_names)
  length   = 48
  special  = false
}

resource "aws_secretsmanager_secret" "generated" {
  for_each                = toset(var.generated_secret_names)
  name                    = "${var.name_prefix}/${each.key}"
  recovery_window_in_days = var.recovery_window_days
  tags                    = merge(var.tags, { Name = "${var.name_prefix}-${each.key}" })
}

resource "aws_secretsmanager_secret_version" "generated" {
  for_each      = toset(var.generated_secret_names)
  secret_id     = aws_secretsmanager_secret.generated[each.key].id
  secret_string = random_password.generated[each.key].result
}

# DATABASE_URL — built by the caller from the RDS module's outputs and passed in.
resource "aws_secretsmanager_secret" "database_url" {
  name                    = "${var.name_prefix}/database_url"
  recovery_window_in_days = var.recovery_window_days
  tags                    = merge(var.tags, { Name = "${var.name_prefix}-database_url" })
}

resource "aws_secretsmanager_secret_version" "database_url" {
  secret_id     = aws_secretsmanager_secret.database_url.id
  secret_string = var.database_url
}

# Azure AD values are external — they come from an app registration in
# Microsoft Entra ID and must be supplied as Terraform variables (via a
# gitignored *.auto.tfvars, CI secret store, or -var on the command line).
resource "aws_secretsmanager_secret" "azure_ad_client_id" {
  name                    = "${var.name_prefix}/azure_ad_client_id"
  recovery_window_in_days = var.recovery_window_days
  tags                    = merge(var.tags, { Name = "${var.name_prefix}-azure_ad_client_id" })
}

resource "aws_secretsmanager_secret_version" "azure_ad_client_id" {
  secret_id     = aws_secretsmanager_secret.azure_ad_client_id.id
  secret_string = var.azure_ad_client_id
}

resource "aws_secretsmanager_secret" "azure_mail_client_secret" {
  name                    = "${var.name_prefix}/azure_mail_client_secret"
  recovery_window_in_days = var.recovery_window_days
  tags                    = merge(var.tags, { Name = "${var.name_prefix}-azure_mail_client_secret" })
}

resource "aws_secretsmanager_secret_version" "azure_mail_client_secret" {
  secret_id     = aws_secretsmanager_secret.azure_mail_client_secret.id
  secret_string = var.azure_mail_client_secret
}
