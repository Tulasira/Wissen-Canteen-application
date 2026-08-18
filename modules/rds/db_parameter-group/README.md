# RDS DB Parameter Group Module

## Overview

This module provisions a reusable Amazon RDS DB Parameter Group using Terraform.

A DB Parameter Group manages database engine configuration parameters that control the behavior and performance of an RDS instance. By default, this module creates a custom Parameter Group with no parameter overrides configured, resulting in behavior equivalent to the AWS default Parameter Group.

The module is designed to be reusable and future-ready by allowing parameter overrides to be configured dynamically through Terraform variables without requiring changes to the module code.

---

## Purpose

An RDS DB Parameter Group controls database engine configuration settings.

This module:

- Creates a reusable custom DB Parameter Group
- Supports configurable database engine families
- Allows dynamic parameter configuration
- Eliminates future module code changes by using Terraform variables

---

## Architecture Flow

```text
terraform.tfvars
        │
        ▼
db_parameters
        │
        ▼
variables.tf
        │
        ▼
RDS DB Parameter Group Module
        │
        ▼
aws_db_parameter_group
        │
        ▼
Amazon RDS DB Instance
```

---

## Resources Created

- `aws_db_parameter_group`

---

## Features

- Reusable Terraform module
- Environment-based resource naming
- Dynamic parameter configuration using `for_each`
- Supports multiple parameter overrides
- No module changes required for future database tuning
- Common tagging strategy
- Behaves like the AWS default Parameter Group when no parameters are configured

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable Parameter Group creation |
| project_name | Project name |
| environment | Environment name |
| parameter_group_family | Database parameter family (for example, mysql8.0) |
| db_parameters | List of database parameter overrides |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| parameter_group_name | Name of the created DB Parameter Group |

---

## Example Usage

```hcl
module "db_parameter_group" {
  source = "../../modules/rds/db-parameter-group"

  enabled      = var.rds_enabled
  project_name = var.project_name
  environment  = var.environment

  parameter_group_family = var.parameter_group_family
  db_parameters          = var.db_parameters

  tags = local.common_tags
}
```

---

## Current Configuration

The current implementation does not configure any custom database parameters.

```hcl
parameter_group_family = "mysql8.0"

db_parameters = []
```

Since `db_parameters` is empty, the created Parameter Group behaves the same as the AWS default Parameter Group while still allowing future customization.

---

## Example Custom Configuration

Database parameters can be added directly from `terraform.tfvars`.

```hcl
db_parameters = [
  {
    name         = "max_connections"
    value        = "300"
    apply_method = "pending-reboot"
  },
  {
    name         = "slow_query_log"
    value        = "1"
    apply_method = "immediate"
  },
  {
    name         = "long_query_time"
    value        = "2"
    apply_method = "immediate"
  }
]
```

No modifications to the Terraform module are required.

---

## Future Enhancements

The module can easily support additional database parameter tuning, including:

- Memory optimization
- Connection limits
- Query logging
- Performance tuning
- Replication settings
- Database engine-specific parameters

All enhancements can be managed through Terraform variables without modifying the module.

---

## Related Modules

- db-instance
- db-option-group
- db-subnet-group
- db-monitoring
- secrets-manager

---

## Notes

- Creates a custom Amazon RDS DB Parameter Group.
- Supports dynamic parameter configuration.
- Behaves like the AWS default Parameter Group when no custom parameters are provided.
- Database tuning is managed entirely through Terraform variables.
- The Parameter Group is attached to the RDS DB Instance by the `db-instance` module.
- The module follows a reusable and environment-independent Terraform design.