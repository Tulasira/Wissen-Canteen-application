# Network ACL Rule Module

## Overview

This module provisions ingress and egress rules for Public, Private Application, and Database Network ACLs.

Network ACL rules provide subnet-level traffic filtering by defining which inbound and outbound traffic is allowed or denied. The module is designed to work with the reusable `nacl` module and supports configurable rule definitions through Terraform variables.

---

## Purpose

This module provides reusable Network ACL rule management for different subnet tiers.

The module:

- Creates Public NACL rules
- Creates Private Application NACL rules
- Creates Database NACL rules
- Supports configurable ingress and egress rules
- Enables secure subnet-level traffic filtering
- Eliminates hardcoded rule definitions

---

## Architecture Flow

```text
                    Internet
                        │
                        ▼
              Public NACL Rules
                        │
                        ▼
                  Public NACL
                        │
                        ▼
                 Public Subnets
                        │
                        ▼
              ALB / Public Resources


                 Application Layer
                        │
                        ▼
        Private Application NACL Rules
                        │
                        ▼
          Private Application NACL
                        │
                        ▼
         ECS / EC2 / Internal ALB


                  Database Layer
                        │
                        ▼
              Database NACL Rules
                        │
                        ▼
                 Database NACL
                        │
                        ▼
                  Amazon RDS
```

---

## Resources Created

### Public Network ACL Rules

- `aws_network_acl_rule.public_ingress`
- `aws_network_acl_rule.public_egress`

### Private Application Network ACL Rules

- `aws_network_acl_rule.private_app_ingress`
- `aws_network_acl_rule.private_app_egress`

### Database Network ACL Rules

- `aws_network_acl_rule.db_ingress`
- `aws_network_acl_rule.db_egress`

---

## Features

- Configurable Public NACL rules
- Configurable Private Application NACL rules
- Configurable Database NACL rules
- Supports multiple ingress and egress rules
- Rule priority using rule numbers
- Environment-independent reusable module
- Works with reusable NACL module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable NACL rule creation |
| public_nacl_id | Public Network ACL ID |
| private_app_nacl_id | Private Application Network ACL ID |
| db_nacl_id | Database Network ACL ID |
| public_nacl_ingress_rules | Public subnet ingress rules |
| public_nacl_egress_rules | Public subnet egress rules |
| private_app_nacl_ingress_rules | Private application subnet ingress rules |
| private_app_nacl_egress_rules | Private application subnet egress rules |
| db_nacl_ingress_rules | Database subnet ingress rules |
| db_nacl_egress_rules | Database subnet egress rules |

---

## Outputs

| Name | Description |
|------|-------------|
| public_ingress_rule_ids | IDs of Public ingress rules |
| public_egress_rule_ids | IDs of Public egress rules |
| private_app_ingress_rule_ids | IDs of Private Application ingress rules |
| private_app_egress_rule_ids | IDs of Private Application egress rules |
| db_ingress_rule_ids | IDs of Database ingress rules |
| db_egress_rule_ids | IDs of Database egress rules |

---

## Example Usage

```hcl
module "nacl_rule" {
  source = "../../modules/vpc/nacl_rule"

  enabled = var.vpc_enabled && var.enable_nacl

  public_nacl_id      = module.nacl.public_nacl_id
  private_app_nacl_id = module.nacl.private_app_nacl_id
  db_nacl_id          = module.nacl.db_nacl_id

  public_nacl_ingress_rules      = var.public_nacl_ingress_rules
  public_nacl_egress_rules       = var.public_nacl_egress_rules

  private_app_nacl_ingress_rules = local.private_app_nacl_ingress_rules
  private_app_nacl_egress_rules  = local.private_app_nacl_egress_rules

  db_nacl_ingress_rules = local.db_nacl_ingress_rules
  db_nacl_egress_rules  = local.db_nacl_egress_rules
}
```

---

## Security Benefits

### Public Subnet Rules

Typically allow:

- HTTP (80)
- HTTPS (443)
- Ephemeral Ports (1024–65535)

Used for:

- Internet-facing ALB
- Bastion Host
- Public EC2

---

### Private Application Subnet Rules

Typically allow:

- HTTP / HTTPS from trusted sources
- Internal VPC communication
- Ephemeral ports for return traffic

Used for:

- ECS Services
- Private EC2
- Internal ALB

---

### Database Subnet Rules

Typically allow:

- MySQL (3306)
- Internal VPC communication
- Required return traffic

Used for:

- Amazon RDS
- Database workloads

---

## Related Modules

- nacl
- vpc
- subnets
- security-group

---

## Notes

- Network ACL rules are evaluated in ascending rule number order.
- Lower rule numbers have higher priority.
- Network ACLs are stateless, so both inbound and outbound rules must be explicitly configured.
- Separate rule sets are recommended for Public, Private Application, and Database subnet tiers.
- Rule definitions are provided through Terraform variables, making the module reusable across environments.
- This module manages only Network ACL rules. Network ACL creation and subnet associations are handled by the `nacl` module.
- The module follows a reusable and environment-independent Terraform design.