# NAT Gateway Module

## Overview

This module provisions an AWS NAT Gateway along with an Elastic IP (EIP).

A NAT Gateway enables resources in private subnets to access the internet for outbound communication, such as downloading software updates or accessing external APIs, while preventing direct inbound internet access.

The NAT Gateway is deployed in a public subnet and is intended to be associated with private route tables.

---

## Purpose

This module provides a reusable way to provision outbound internet access for private subnets.

The module:

- Creates an Elastic IP
- Creates a NAT Gateway
- Deploys the NAT Gateway in a public subnet
- Supports private subnet internet connectivity
- Follows reusable Terraform design

---

## Architecture Flow

```text
Private Application Subnet
           │
           ▼
Private Route Table
           │
           ▼
      NAT Gateway
           │
           ▼
     Public Subnet
           │
           ▼
   Internet Gateway
           │
           ▼
        Internet
```

---

## Resources Created

- `aws_eip`
- `aws_nat_gateway`

---

## Features

- Creates an Elastic IP
- Creates a NAT Gateway
- Deploys NAT Gateway in a public subnet
- Enables outbound internet access for private subnets
- Prevents direct inbound internet access
- Environment-based resource naming
- Common tagging strategy
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable NAT Gateway creation |
| project_name | Project name |
| environment | Environment name |
| public_subnet_id | Public subnet where the NAT Gateway will be deployed |
| internet_gateway_id | Internet Gateway ID (used to establish deployment dependency) |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| nat_gateway_id | NAT Gateway ID |
| nat_gateway_public_ip | Elastic IP attached to the NAT Gateway |
| nat_gateway_allocation_id | Elastic IP Allocation ID |

---

## Example Usage

```hcl
module "nat_gateway" {
  source = "../../modules/vpc/nat-gateway"

  enabled             = true
  project_name        = var.project_name
  environment         = var.environment
  public_subnet_id    = module.subnets.public_subnet_ids[0]
  internet_gateway_id = module.internet_gateway.internet_gateway_id

  tags = local.common_tags
}
```

---

## Security Benefits

- Private resources remain inaccessible from the internet.
- Only outbound internet access is allowed.
- Works with private route tables to isolate application resources.
- Supports secure software updates and external API access.

---

## Related Modules

- vpc
- internet_gateway
- route_table
- route
- subnets

---

## Notes

- This module creates only the NAT Gateway and its Elastic IP.
- The NAT Gateway must always be deployed in a public subnet.
- A private route table must contain a default route (`0.0.0.0/0`) pointing to the NAT Gateway for outbound internet access.
- This module is not currently deployed in the **dev** environment because NAT Gateway is a paid AWS resource.
- The Internet Gateway should be created before the NAT Gateway. This dependency is automatically handled through module references in the root configuration.
- The module follows a reusable and environment-independent Terraform design.