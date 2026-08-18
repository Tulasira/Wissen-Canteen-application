# DB Subnet Group Module

## Overview

This module provisions an Amazon RDS DB Subnet Group using private database subnets.

A DB Subnet Group defines the set of private subnets where Amazon RDS is allowed to deploy database instances. It enables secure database placement within a VPC while supporting high availability through Multi-Availability Zone (Multi-AZ) deployments.

The DB Subnet Group is consumed by the RDS DB Instance module during database creation.

---

## Purpose

An RDS DB Subnet Group specifies the private subnets available for database deployment.

This module:

- Creates a reusable DB Subnet Group
- Deploys databases inside private database subnets
- Supports Multi-AZ database deployments
- Improves network isolation and security
- Eliminates hardcoded subnet references

---

## Architecture Flow

```text
Terraform
      │
      ▼
Database Subnet IDs
      │
      ▼
DB Subnet Group Module
      │
      ▼
aws_db_subnet_group
      │
      ▼
Amazon RDS DB Instance
      │
      ▼
Private Database Subnets
      │
      ▼
VPC
```

---

## Resources Created

- `aws_db_subnet_group`

---

## Features

- Uses private database subnets
- Supports Multi-AZ deployments
- Improves database security
- Provides subnet isolation for RDS
- Environment-based resource naming
- Common tagging strategy
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable DB Subnet Group creation |
| project_name | Project name |
| environment | Environment name |
| db_subnet_ids | List of private database subnet IDs |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| db_subnet_group_name | Name of the created DB Subnet Group |

---

## Example Usage

```hcl
module "db_subnet_group" {
  source = "../../modules/rds/db-subnet-group"

  enabled      = var.rds_enabled
  project_name = var.project_name
  environment  = var.environment

  db_subnet_ids = module.subnets.db_subnet_ids

  tags = local.common_tags
}
```

---

## Current Development Configuration

The current deployment uses dedicated private database subnets across two Availability Zones.

```hcl
db_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]
```

These subnets are associated with the DB Subnet Group and used by the RDS instance.

---

## Security Benefits

- Deploys Amazon RDS inside private database subnets.
- Prevents direct internet access to the database.
- Provides network isolation between application and database layers.
- Supports secure communication within the VPC.
- Enables highly available Multi-AZ database deployments.

---

## Related Modules

- db-instance
- vpc
- subnets
- security-group
- secrets-manager

---

## Notes

- This module creates only the Amazon RDS DB Subnet Group.
- It does not create an RDS database instance.
- A DB Subnet Group is mandatory for RDS deployments inside a VPC.
- It is recommended to use at least two private database subnets across different Availability Zones.
- The DB Subnet Group is consumed by the `db-instance` module.
- Security Groups, DB Parameter Groups, DB Option Groups, Monitoring, and Secrets Manager are managed through separate reusable modules.
- The module follows a reusable and environment-independent Terraform design.