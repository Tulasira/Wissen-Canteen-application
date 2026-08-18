# Secrets Manager Module

## Overview

This module provisions and manages database credentials securely using AWS Secrets Manager.

Instead of hardcoding usernames and passwords in Terraform code, the module automatically generates a strong random password and stores the credentials securely in AWS Secrets Manager.

The stored credentials are consumed by the Amazon RDS DB Instance module during database provisioning, following AWS security best practices.

---

## Purpose

This module provides a secure and reusable mechanism for managing database credentials.

The module:

- Creates an AWS Secrets Manager secret
- Generates a strong random password
- Stores credentials in JSON format
- Eliminates hardcoded credentials
- Integrates seamlessly with the RDS module

---

## Architecture Flow

```text
Terraform
      │
      ▼
Random Password
      │
      ▼
AWS Secrets Manager
      │
      ▼
Secret Version
      │
      ▼
Credentials (JSON)
      │
      ▼
RDS DB Instance Module
      │
      ▼
Amazon RDS
```

---

## Resources Created

- `aws_secretsmanager_secret`
- `aws_secretsmanager_secret_version`
- `random_password`

---

## Features

- Automatic password generation
- Secure credential storage
- Configurable password complexity
- JSON formatted credentials
- AWS Secrets Manager integration
- Amazon RDS integration
- Recovery window configuration
- Environment-based naming
- Common tagging strategy
- Reusable Terraform module

---

## Secret Format

Credentials are stored as JSON.

```json
{
  "username": "adminuser",
  "password": "generated-password"
}
```

---

## Inputs

| Name | Description |
|------|-------------|
| secret_name | Name of the Secrets Manager secret |
| secret_description | Secret description |
| db_username | Database username |
| password_length | Length of generated password |
| override_special | Allowed special characters |
| min_lower | Minimum lowercase characters |
| min_upper | Minimum uppercase characters |
| min_numeric | Minimum numeric characters |
| min_special | Minimum special characters |
| recovery_window_days | Recovery window before permanent deletion |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| secret_arn | ARN of the created secret |
| secret_id | Secret ID |
| secret_string | JSON containing username and password |

---

## Example Usage

```hcl
module "secrets_manager" {
  source = "../../modules/secrets-manager"

  secret_name        = var.secret_name
  secret_description = var.secret_description

  db_username      = var.db_username
  password_length  = var.password_length
  override_special = var.override_special

  min_lower   = var.min_lower
  min_upper   = var.min_upper
  min_numeric = var.min_numeric
  min_special = var.min_special

  recovery_window_days = var.recovery_window_days

  tags = local.common_tags
}
```

---

## Current Development Configuration

```hcl
secret_name        = "vpc-alb-rds-dev-db-credentials"
db_username         = "adminuser"

password_length     = 16
min_lower           = 2
min_upper           = 2
min_numeric         = 2
min_special         = 2

override_special    = "!#$%*-_=+"
```

The current configuration generates a strong password and stores the database credentials securely in AWS Secrets Manager.

---

## Security Benefits

- Database credentials are never hardcoded.
- Strong random passwords are automatically generated.
- Credentials are securely stored in AWS Secrets Manager.
- Access can be controlled using IAM policies.
- Supports secure credential rotation.
- Sensitive values remain protected from accidental exposure.
- Improves security and compliance by separating secrets from infrastructure code.

---

## Related Modules

- db-instance
- db-parameter-group
- db-option-group
- db-subnet-group
- db-monitoring

---

## Notes

- This module is primarily designed for Amazon RDS credential management.
- Passwords are generated according to the configured complexity requirements.
- The `secret_string` output is marked as sensitive and should not be exposed in logs.
- Database credentials are retrieved by the `db-instance` module during RDS provisioning.
- The module follows a reusable and environment-independent Terraform design.
- Using AWS Secrets Manager improves security, maintainability, and operational best practices compared to storing credentials in code or configuration files.