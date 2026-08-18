# Subnets Module

## Overview

This module provisions Public, Private Application, and Database subnets across multiple Availability Zones within a VPC.

Each subnet tier serves a specific purpose:

- **Public Subnets** host internet-facing resources such as Application Load Balancers (ALBs) and NAT Gateways.
- **Private Application Subnets** host application workloads such as ECS services or private EC2 instances.
- **Database Subnets** host backend database resources such as Amazon RDS.

The module distributes subnets across multiple Availability Zones to improve high availability and fault tolerance.

---

## Purpose

This module provides a reusable way to provision subnet tiers within a VPC.

The module:

- Creates Public Subnets
- Creates Private Application Subnets
- Creates Database Subnets
- Supports Multi-AZ deployments
- Follows reusable Terraform design

---

## Architecture Flow

```text
                    VPC
                     │
     ┌───────────────┼────────────────┐
     │               │                │
     ▼               ▼                ▼
Public Subnets   Private App     Database Subnets
                 Subnets
     │               │                │
     ▼               ▼                ▼
 ALB / NAT      ECS / EC2          Amazon RDS
 Gateway
```

---

## Resources Created

- `aws_subnet.public`
- `aws_subnet.private_app`
- `aws_subnet.db`

---

## Features

- Multi-AZ subnet deployment
- Public subnet support
- Private application subnet support
- Database subnet support
- High availability architecture
- Network segmentation
- Environment-based resource naming
- Common tagging strategy
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable subnet creation |
| project_name | Project name |
| environment | Environment name |
| vpc_id | VPC ID |
| public_subnet_cidrs | CIDR blocks for Public subnets |
| private_app_subnet_cidrs | CIDR blocks for Private Application subnets |
| db_subnet_cidrs | CIDR blocks for Database subnets |
| availability_zones | Availability Zones |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| public_subnet_ids | IDs of Public subnets |
| private_app_subnet_ids | IDs of Private Application subnets |
| db_subnet_ids | IDs of Database subnets |

---

## Example Usage

```hcl
module "subnets" {
  source = "../../modules/vpc/subnets"

  enabled      = var.vpc_enabled
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id

  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  db_subnet_cidrs          = var.db_subnet_cidrs
  availability_zones       = var.availability_zones

  tags = local.common_tags
}
```

---

## Subnet Types

### Public Subnets

Designed for internet-facing resources.

Typical workloads:

- Application Load Balancer (Internet-facing)
- NAT Gateway
- Bastion Host
- Public EC2 Instances

Features:

- Auto-assign public IP enabled
- Associated with Public Route Table
- Internet Gateway connectivity

---

### Private Application Subnets

Designed for application workloads that should not be directly accessible from the internet.

Typical workloads:

- ECS Services
- Private EC2 Instances
- Internal Application Load Balancer

Features:

- No public IP assignment
- Associated with Private Route Table
- Outbound internet access through NAT Gateway (if configured)

---

### Database Subnets

Designed for backend database services.

Typical workloads:

- Amazon RDS
- Other managed database services

Features:

- No public IP assignment
- Used by DB Subnet Groups
- Isolated from direct internet access

---

## Security Benefits

- Separates Public, Application, and Database workloads.
- Reduces attack surface through network segmentation.
- Supports least-privilege networking.
- Enables secure communication between application and database tiers.
- Improves availability through Multi-AZ deployment.

---

## Related Modules

- vpc
- route_table
- route
- nacl
- security-group
- db-subnet-group

---

## Notes

- Public subnets are intended for internet-facing resources.
- Private Application subnets host application workloads and can optionally use a NAT Gateway for outbound internet access.
- Database subnets are intended only for backend database services such as Amazon RDS.
- Database subnets are typically associated with an RDS DB Subnet Group.
- Deploying subnets across multiple Availability Zones improves availability and fault tolerance.
- The module follows a reusable and environment-independent Terraform design.