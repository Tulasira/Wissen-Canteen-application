# RDS DB Instance Module

## Overview

This module provisions a private Amazon RDS DB Instance using a reusable Terraform module.

The database is deployed inside private database subnets and integrates with separate Terraform modules for DB Subnet Groups, DB Parameter Groups, DB Option Groups, Security Groups, Secrets Manager, and Enhanced Monitoring.

Database credentials are securely retrieved from AWS Secrets Manager, eliminating the need to hardcode usernames or passwords.

The module supports configurable monitoring, backup, maintenance, encryption, and authentication features, making it suitable for reusable enterprise deployments.

---

## Architecture Flow

```text
AWS Secrets Manager
        │
        ▼
Database Credentials
        │
        ▼
RDS DB Instance
        │
 ┌──────┼───────────────┐
 ▼      ▼               ▼
DB Parameter Group   DB Option Group
        │
        ▼
DB Subnet Group
        │
        ▼
Private Database Subnets
        │
        ▼
VPC
```

---

## Resources Created

- `aws_db_instance`

---

## Features

- Private RDS deployment
- Supports configurable database engine and version
- Credentials securely retrieved from AWS Secrets Manager
- Custom DB Parameter Group support
- Custom DB Option Group support
- Storage encryption enabled
- IAM Database Authentication support
- Configurable Performance Insights
- Supports both Standard and Enhanced Monitoring
- Automated backups
- Preferred backup window
- Preferred maintenance window
- Auto minor version upgrades
- Copy tags to snapshots
- Environment-based naming
- Common tagging strategy
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable RDS instance creation |
| project_name | Project name |
| environment | Environment name |
| db_subnet_group_name | Database subnet group |
| security_group_ids | Security Groups attached to the RDS instance |
| parameter_group_name | DB Parameter Group |
| option_group_name | DB Option Group |
| db_name | Initial database name |
| db_secret_string | Database credentials retrieved from AWS Secrets Manager |
| engine | Database engine |
| engine_version | Database engine version |
| instance_class | RDS instance class |
| allocated_storage | Allocated storage |
| storage_type | Storage type |
| multi_az | Enable or disable Multi-AZ |
| iam_database_authentication_enabled | IAM Database Authentication |
| performance_insights_enabled | Enable Performance Insights |
| performance_insights_retention_period | Performance Insights retention period |
| monitoring_interval | Monitoring interval (0 = Standard Monitoring, >0 = Enhanced Monitoring) |
| monitoring_role_arn | IAM Role ARN used for Enhanced Monitoring |
| deletion_protection | Enable deletion protection |
| skip_final_snapshot | Skip final snapshot |
| backup_retention_period | Automated backup retention |
| preferred_backup_window | Backup window |
| preferred_maintenance_window | Maintenance window |
| auto_minor_version_upgrade | Automatic minor version upgrades |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| rds_identifier | RDS instance identifier |
| rds_endpoint | Database endpoint |
| rds_arn | ARN of the RDS instance |

---

## Example Usage

```hcl
module "db_instance" {
  source = "../../modules/rds/db-instance"

  enabled      = var.rds_enabled
  project_name = var.project_name
  environment  = var.environment

  db_subnet_group_name = module.db_subnet_group.db_subnet_group_name
  security_group_ids   = [module.rds_security_group.security_group_id]

  parameter_group_name = module.db_parameter_group.parameter_group_name
  option_group_name    = module.db_option_group.option_group_name

  db_name          = var.db_name
  db_secret_string = module.secrets_manager.secret_string

  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  allocated_storage = var.db_allocated_storage
  storage_type      = var.db_storage_type
  multi_az          = var.db_multi_az

  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period

  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = module.db_monitoring.monitoring_role_arn

  deletion_protection     = var.db_deletion_protection
  skip_final_snapshot     = var.db_skip_final_snapshot
  backup_retention_period = var.db_backup_retention_period

  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window

  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  tags = local.common_tags
}
```

---

## Monitoring

The module supports both Standard Monitoring and Enhanced Monitoring.

### Standard Monitoring

```hcl
monitoring_interval = 0
```

Uses standard Amazon CloudWatch metrics without requiring an IAM Role.

### Enhanced Monitoring

```hcl
monitoring_interval = 60
```

Creates and uses an IAM Role to collect operating system metrics from the RDS instance.

---

## Current Development Configuration

```hcl
db_engine         = "mysql"
db_engine_version = "8.0"

parameter_group_family = "mysql8.0"
db_parameters = []

option_group_engine_name = "mysql"
major_engine_version     = "8.0"

db_options = []

monitoring_interval = 0
```

The current configuration behaves like the AWS default Parameter Group and Option Group because no custom overrides are defined.

---

## Security Benefits

- Database deployed in private database subnets
- Public access disabled
- Credentials securely stored in AWS Secrets Manager
- No hardcoded passwords
- Storage encryption enabled
- Security Group controlled access
- IAM Database Authentication support
- Optional Performance Insights
- Optional Enhanced Monitoring
- Automated backups for recovery
- Snapshot tagging enabled

---

## Related Modules

- db-subnet-group
- db-parameter-group
- db-option-group
- db-monitoring
- secrets-manager
- security-group

---

## Notes

- Creates only the Amazon RDS DB Instance.
- The DB Subnet Group, Parameter Group, and Option Group are managed by separate reusable modules.
- Database credentials are retrieved securely from AWS Secrets Manager.
- Enhanced Monitoring is enabled only when `monitoring_interval` is greater than `0`.
- Standard Monitoring is used when `monitoring_interval` is set to `0`.
- Future database tuning can be achieved by updating `db_parameters` and `db_options` in `terraform.tfvars` without modifying the Terraform modules.
- For production environments, Multi-AZ deployment, deletion protection, and Enhanced Monitoring are recommended.