# Route Table Module

## Overview

This module provisions AWS Route Tables and associates them with the appropriate subnets.

The module supports creating Route Tables for different subnet tiers, such as Public and Private Application subnets. Route Table associations ensure that each subnet uses the correct routing configuration based on its purpose.

Routes themselves are managed separately through the reusable `route` module.

---

## Purpose

This module provides a reusable way to manage Route Tables and subnet associations.

The module:

- Creates Route Tables
- Associates Route Tables with subnets
- Supports Public and Private Application subnet tiers
- Works with Internet Gateway and NAT Gateway routes
- Follows reusable Terraform design

---

## Architecture Flow

### Public Route Table

```text
Internet
      │
      ▼
Internet Gateway
      │
      ▼
Public Route
      │
      ▼
Public Route Table
      │
      ▼
Public Subnet Associations
      │
      ▼
ALB / Bastion Host / Public EC2
```

---

### Private Application Route Table

```text
Private Application Subnets
            │
            ▼
Private Route Table
            │
            ▼
NAT Gateway Route
            │
            ▼
NAT Gateway
            │
            ▼
Internet Gateway
            │
            ▼
Internet
```

---

## Resources Created

- `aws_route_table`
- `aws_route_table_association`

---

## Features

- Supports Public Route Tables
- Supports Private Application Route Tables
- Automatic subnet association
- Environment-based resource naming
- Common tagging strategy
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable Route Table creation |
| project_name | Project name |
| environment | Environment name |
| vpc_id | VPC ID |
| route_table_name | Name of the Route Table |
| tier | Network tier (public, private-app, etc.) |
| subnet_ids | List of subnet IDs associated with the Route Table |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| route_table_id | ID of the created Route Table |

---

## Example Usage

### Public Route Table

```hcl
module "public_route_table" {
  source = "../../modules/vpc/route_table"

  enabled          = var.vpc_enabled
  project_name     = var.project_name
  environment      = var.environment

  vpc_id           = module.vpc.vpc_id
  route_table_name = "${var.project_name}-${var.environment}-public-rt"
  tier             = "public"

  subnet_ids = module.subnets.public_subnet_ids

  tags = local.common_tags
}
```

---

### Private Application Route Table

```hcl
module "private_app_route_table" {
  source = "../../modules/vpc/route_table"

  enabled          = var.vpc_enabled
  project_name     = var.project_name
  environment      = var.environment

  vpc_id           = module.vpc.vpc_id
  route_table_name = "${var.project_name}-${var.environment}-private-app-rt"
  tier             = "private-app"

  subnet_ids = module.subnets.private_app_subnet_ids

  tags = local.common_tags
}
```

---

## Security Benefits

- Enables different routing policies for different subnet tiers.
- Supports network segmentation.
- Prevents private application subnets from requiring direct Internet Gateway access.
- Improves maintainability through separate routing configurations.

---

## Related Modules

- vpc
- subnets
- route
- internet_gateway
- nat_gateway

---

## Notes

- This module creates only Route Tables and their subnet associations.
- Routes are managed separately through the `route` module.
- Public Route Tables typically use routes pointing to an Internet Gateway.
- Private Application Route Tables typically use routes pointing to a NAT Gateway.
- Multiple subnets can share the same Route Table.
- The module follows a reusable and environment-independent Terraform design.