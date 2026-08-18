# VPC Module

## Overview

This module provisions the core AWS Virtual Private Cloud (VPC), which serves as the networking foundation for all infrastructure resources deployed within the environment.

The VPC provides network isolation, private IP addressing, DNS support, and secure communication between AWS resources. All networking components such as subnets, route tables, Internet Gateway, NAT Gateway, Network ACLs, and Security Groups are deployed within the VPC.

---

## Purpose

This module provides a reusable way to provision the networking foundation for AWS workloads.

The module:

- Creates a dedicated VPC
- Configures DNS support and DNS hostnames
- Supports custom CIDR blocks
- Acts as the parent network for all infrastructure resources
- Follows reusable Terraform design

---

## Architecture Flow

```text
AWS Account
      │
      ▼
      VPC
      │
 ┌────┼───────────────────────────────┐
 │    │               │               │
 ▼    ▼               ▼               ▼
Public Subnets   Private App     Database Subnets
                 Subnets
 │                  │                  │
 ▼                  ▼                  ▼
ALB / NAT      ECS / EC2          Amazon RDS
Gateway

                │
                ▼
             Amazon S3
```

---

## Resources Created

- `aws_vpc`

---

## Features

- Dedicated AWS network
- Custom CIDR block
- DNS hostnames enabled
- DNS resolution enabled
- Network isolation
- Environment-based resource naming
- Common tagging strategy
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable VPC creation |
| project_name | Project name |
| environment | Environment name |
| vpc_cidr | CIDR block assigned to the VPC |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the created VPC |

---

## Example Usage

```hcl
module "vpc" {
  source = "../../modules/vpc/vpc"

  enabled      = var.vpc_enabled
  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr

  tags = local.common_tags
}
```

---

## Network Components

The VPC acts as the parent network for:

- Public Subnets
- Private Application Subnets
- Database Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Routes
- Network ACLs
- Security Groups
- Application Load Balancer
- Amazon ECS
- Amazon RDS

---

## Security Benefits

- Provides logical network isolation.
- Supports secure communication between application and database tiers.
- Enables network segmentation using multiple subnet tiers.
- Supports controlled internet access using Internet Gateway and NAT Gateway.
- Acts as the foundation for secure AWS infrastructure.

---

## Related Modules

- subnets
- internet_gateway
- nat_gateway
- route_table
- route
- nacl
- nacl_rule
- security-group
- alb
- ecs
- rds

---

## Notes

- This module creates only the VPC.
- All networking resources are deployed inside the VPC.
- The VPC CIDR block should be planned carefully to avoid overlapping IP ranges.
- DNS support and DNS hostnames are enabled to allow AWS resources to resolve and receive DNS names.
- Public subnets are intended for internet-facing resources.
- Private Application subnets host application workloads.
- Database subnets host backend database services such as Amazon RDS.
- The module follows a reusable and environment-independent Terraform design.