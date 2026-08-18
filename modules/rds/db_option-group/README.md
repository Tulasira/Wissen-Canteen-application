# RDS DB Option Group Module

## Overview

This module provisions a reusable Amazon RDS DB Option Group using Terraform.

An Option Group enables database engine-specific features and options for an RDS instance. By default, this module creates a custom Option Group with no additional options configured, resulting in behavior equivalent to the AWS default Option Group.

The module is designed to be reusable and future-ready by allowing database options to be configured dynamically through Terraform variables without requiring changes to the module code.

---

## Purpose

An RDS DB Option Group manages optional database engine features that are not enabled by default.

This module:

- Creates a reusable custom DB Option Group
- Supports configurable database engine and major version
- Allows dynamic option configuration
- Eliminates future module code changes by using Terraform variables

---

## Architecture Flow

```text
terraform.tfvars
        │
        ▼
db_options
        │
        ▼
variables.tf
        │
        ▼
RDS DB Option Group Module
        │
        ▼
aws_db_option_group
        │
        ▼
Amazon RDS DB Instance
```

---

## Resources Created

- `aws_db_option_group`

---

## Features

- Reusable Terraform module
- Environment-based resource naming
- Dynamic option configuration using `for_each`
- Supports multiple database options
- No module changes required for future enhancements
- Common tagging strategy
- Behaves like the AWS default Option Group when no options are configured

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable Option Group creation |
| project_name | Project name |
| environment | Environment name |
| option_group_engine_name | Database engine (for example, mysql) |
| major_engine_version | Major engine version (for example, 8.0) |
| db_options | List of database options |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| option_group_name | Name of the created DB Option Group |

---

## Example Usage

```hcl
module "db_option_group" {
  source = "../../modules/rds/db-option-group"

  enabled      = var.rds_enabled
  project_name = var.project_name
  environment  = var.environment

  option_group_engine_name = var.option_group_engine_name
  major_engine_version     = var.major_engine_version
  db_options               = var.db_options

  tags = local.common_tags
}
```

---

## Current Configuration

The current implementation does not configure any custom database options.

```hcl
option_group_engine_name = "mysql"
major_engine_version     = "8.0"

db_options = []
```

Since `db_options` is empty, the created Option Group behaves the same as the AWS default Option Group while still allowing future customization.

---

## Example Custom Configuration

Database options can be added directly from `terraform.tfvars`.

```hcl
db_options = [
  {
    option_name = "MEMCACHED"

    option_settings = [
      {
        name  = "CHUNK_SIZE"
        value = "32"
      },
      {
        name  = "CACHE_SIZE"
        value = "2048"
      }
    ]
  }
]
```

No modifications to the Terraform module are required.

---

## Future Enhancements

The module can easily support additional database options, including:

- Oracle Enterprise Manager
- SQL Server Backup and Restore
- Oracle TDE
- OEM Agent
- Native Backup Features
- Database-specific engine options

All enhancements can be managed through Terraform variables without modifying the module.

---

## Related Modules

- db-instance
- db-parameter-group
- db-subnet-group
- db-monitoring
- secrets-manager

---

## Notes

- Creates a custom Amazon RDS DB Option Group.
- Supports dynamic database option configuration.
- Behaves like the AWS default Option Group when no custom options are provided.
- Database options are managed entirely through Terraform variables.
- The Option Group is attached to the RDS DB Instance by the `db-instance` module.
- The module follows a reusable and environment-independent Terraform design.