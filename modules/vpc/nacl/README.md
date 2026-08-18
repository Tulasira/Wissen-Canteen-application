# Network ACL Module

## Overview

This module provisions AWS Network Access Control Lists (NACLs) for Public, Private Application, and Database subnets.

Network ACLs provide subnet-level security by controlling inbound and outbound traffic before it reaches resources inside the subnet. Each subnet tier has its own dedicated NACL to improve network isolation and security.

The module creates only the Network ACLs and associates them with their respective subnets. Individual NACL rules are managed separately by the `nacl_rule` module.

---

## Purpose

This module provides reusable subnet-level security for different network tiers.

The module:

- Creates dedicated NACLs for Public, Private Application, and Database subnets
- Associates each NACL with the appropriate subnets
- Improves network segmentation
- Supports reusable Terraform deployments

---

## Architecture Flow

```text
                    Internet
                        │
                        ▼
               Internet Gateway
                        │
                        ▼
                  Public NACL
                        │
                        ▼
                 Public Subnets
                        │
                        ▼
              ALB / Public Resources


                 Private Application
                        │
                        ▼
             Private Application NACL
                        │
                        ▼
            Private Application Subnets
                        │
                        ▼
               ECS / EC2 Applications


                   Database Layer
                        │
                        ▼
                 Database NACL
                        │
                        ▼
               Database Subnets
                        │
                        ▼
                  Amazon RDS
```

---

## Resources Created

- `aws_network_acl` (Public)
- `aws_network_acl` (Private Application)
- `aws_network_acl` (Database)
- `aws_network_acl_association` (Public Subnets)
- `aws_network_acl_association` (Private Application Subnets)
- `aws_network_acl_association` (Database Subnets)

---

## Features

- Dedicated Public NACL
- Dedicated Private Application NACL
- Dedicated Database NACL
- Automatic subnet association
- Improved subnet isolation
- Environment-based naming
- Common tagging strategy
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable NACL creation |
| project_name | Project name |
| environment | Environment name |
| vpc_id | VPC ID |
| public_subnet_ids | Public subnet IDs |
| private_app_subnet_ids | Private application subnet IDs |
| db_subnet_ids | Database subnet IDs |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| public_nacl_id | Public Network ACL ID |
| private_app_nacl_id | Private Application Network ACL ID |
| db_nacl_id | Database Network ACL ID |

---

## Example Usage

```hcl
module "nacl" {
  source = "../../modules/vpc/nacl"

  enabled      = var.vpc_enabled
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id

  public_subnet_ids      = module.subnets.public_subnet_ids
  private_app_subnet_ids = module.subnets.private_app_subnet_ids
  db_subnet_ids          = module.subnets.db_subnet_ids

  tags = local.common_tags
}
```

---

## Security Benefits

### Public NACL

Typically allows:

- HTTP (80)
- HTTPS (443)
- Ephemeral Ports (1024–65535)

Used for:

- Internet-facing ALB
- Bastion Host
- Public EC2

---

### Private Application NACL

Typically allows:

- HTTP / HTTPS from within the VPC
- Ephemeral ports
- Internal application communication

Used for:

- ECS Services
- Private EC2
- Internal ALB

---

### Database NACL

Typically allows:

- MySQL (3306)
- Internal VPC communication
- Required return traffic

Used for:

- Amazon RDS
- Other database services

---

## Related Modules

- nacl_rule
- vpc
- subnets
- route_table
- security-group

---

## Notes

- Network ACLs operate at the subnet level.
- Network ACLs are stateless, so both inbound and outbound rules must be explicitly configured.
- Security Groups provide resource-level security, whereas Network ACLs provide subnet-level security.
- Separate NACLs are recommended for Public, Private Application, and Database subnets.
- This module creates only the Network ACLs and subnet associations.
- Individual NACL rules are managed by the `nacl_rule` module.
- The module follows a reusable and environment-independent Terraform design.