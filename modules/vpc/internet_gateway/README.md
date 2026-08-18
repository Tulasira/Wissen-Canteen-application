# Internet Gateway Module

## Overview

This module provisions an AWS Internet Gateway (IGW) and attaches it to a Virtual Private Cloud (VPC).

An Internet Gateway enables communication between resources inside a VPC and the public internet. It is required for public subnets that host internet-facing resources such as Application Load Balancers (ALBs), Bastion Hosts, or public EC2 instances.

The module creates only the Internet Gateway. Internet connectivity is established by associating a Route Table containing a default route (`0.0.0.0/0`) pointing to the Internet Gateway.

---

## Purpose

This module provides a reusable way to provision and attach an Internet Gateway to a VPC.

The module:

- Creates an Internet Gateway
- Attaches it to a VPC
- Supports public subnet internet connectivity
- Works with Route Table and Route modules
- Follows reusable Terraform design

---

## Architecture Flow

```text
Internet
      │
      ▼
Internet Gateway
      │
      ▼
Public Route
(0.0.0.0/0)
      │
      ▼
Public Route Table
      │
      ▼
Public Subnets
      │
      ▼
ALB / EC2 / Bastion Host
```

---

## Resources Created

- `aws_internet_gateway`

---

## Features

- Creates an Internet Gateway
- Attaches the Internet Gateway to a VPC
- Enables internet connectivity for public subnets
- Environment-based resource naming
- Common tagging strategy
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable Internet Gateway creation |
| project_name | Project name |
| environment | Environment name |
| vpc_id | VPC ID where the Internet Gateway will be attached |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| internet_gateway_id | ID of the created Internet Gateway |

---

## Example Usage

```hcl
module "internet_gateway" {
  source = "../../modules/vpc/internet_gateway"

  enabled      = var.vpc_enabled
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id

  tags = local.common_tags
}
```

---

## Use Cases

The Internet Gateway can be used by:

- Public EC2 instances
- Internet-facing Application Load Balancers (ALB)
- Bastion Hosts
- NAT Gateways
- Public web applications

---

## Related Modules

- vpc
- subnets
- route_table
- route
- nat_gateway

---

## Notes

- This module creates only the Internet Gateway.
- An Internet Gateway alone does not provide internet connectivity.
- Internet access requires a Route Table containing a default route (`0.0.0.0/0`) pointing to the Internet Gateway.
- Only public subnets should use routes that point to an Internet Gateway.
- Private application and database subnets should not be directly associated with an Internet Gateway.
- The module follows a reusable and environment-independent Terraform design.