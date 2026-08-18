# Route Module

## Overview

This module provisions a route within an AWS Route Table.

The module supports creating routes that direct traffic either to an Internet Gateway (IGW) or a NAT Gateway (NAT), making it reusable for both public and private networking scenarios.

It is designed to work with the reusable Route Table module and supports environment-independent deployments.

---

## Purpose

This module provides a reusable way to configure routing within a VPC.

The module:

- Creates Internet Gateway routes
- Creates NAT Gateway routes
- Supports configurable destination CIDR blocks
- Works with public and private route tables
- Follows reusable Terraform design

---

## Architecture Flow

### Public Route

```text
Internet
     │
     ▼
Internet Gateway
     │
     ▼
Route (0.0.0.0/0)
     │
     ▼
Public Route Table
     │
     ▼
Public Subnets
     │
     ▼
ALB / Public EC2
```

---

### Private Route

```text
Private Application Subnets
          │
          ▼
Private Route Table
          │
          ▼
Route (0.0.0.0/0)
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

- `aws_route`

---

## Features

- Supports Internet Gateway routes
- Supports NAT Gateway routes
- Configurable destination CIDR
- Reusable Terraform module
- Supports public and private routing
- Environment-independent design

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable route creation |
| route_table_id | Route Table ID |
| destination_cidr_block | Destination CIDR block |
| internet_gateway_id | Internet Gateway ID (optional) |
| nat_gateway_id | NAT Gateway ID (optional) |

---

## Outputs

| Name | Description |
|------|-------------|
| route_id | ID of the created route |

---

## Example Usage

### Public Route

```hcl
module "public_route" {
  source = "../../modules/vpc/route"

  enabled                = true
  route_table_id         = module.public_route_table.route_table_id
  destination_cidr_block = "0.0.0.0/0"

  internet_gateway_id = module.internet_gateway.internet_gateway_id
  nat_gateway_id      = null
}
```

---

### Private Route

```hcl
module "private_route" {
  source = "../../modules/vpc/route"

  enabled                = true
  route_table_id         = module.private_app_route_table.route_table_id
  destination_cidr_block = "0.0.0.0/0"

  internet_gateway_id = null
  nat_gateway_id      = module.nat_gateway.nat_gateway_id
}
```

---

## Security Benefits

- Enables controlled routing for different subnet tiers.
- Prevents private subnets from requiring direct internet exposure.
- Supports secure outbound internet access through NAT Gateway.
- Keeps routing configuration modular and reusable.

---

## Related Modules

- vpc
- subnets
- route_table
- internet_gateway
- nat_gateway

---

## Notes

- This module creates only a Route.
- Either `internet_gateway_id` or `nat_gateway_id` should be provided depending on the routing requirement.
- Public Route Tables typically use an Internet Gateway.
- Private Route Tables typically use a NAT Gateway.
- Route Table associations are managed separately by the `route_table` module.
- The module follows a reusable and environment-independent Terraform design.