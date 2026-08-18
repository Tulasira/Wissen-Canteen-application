# Security Group Rule Module

## Overview

This module provisions ingress and egress rules for an existing AWS Security Group.

The module is designed separately from the Security Group resource to improve modularity, reusability, and maintainability. It supports both CIDR-based rules and Security Group-based rules, making it suitable for different networking scenarios.

---

## Purpose

This module manages Security Group Rules independently of the Security Group itself.

Separating rules from the Security Group resource allows:

- Reusable Security Groups
- Easier rule management
- Cleaner Terraform modules
- Flexible network configurations

---

## Architecture Flow

```text
Terraform
      │
      ▼
Security Group Module
      │
      ▼
AWS Security Group
      │
      ▼
Security Group Rule Module
      │
      ├──────────────┐
      ▼              ▼
Ingress Rules    Egress Rules
      │              │
      └──────┬───────┘
             ▼
      AWS Resources
(ALB / RDS / ECS / EC2)
```

---

## Resources Created

- `aws_vpc_security_group_ingress_rule` (CIDR-based)
- `aws_vpc_security_group_ingress_rule` (Security Group-based)
- `aws_vpc_security_group_egress_rule`

---

## Features

- Supports CIDR-based ingress rules
- Supports Security Group-based ingress rules
- Supports configurable egress rules
- Reusable Terraform module
- Environment-independent design
- Supports multiple ingress and egress rules
- Common tagging strategy through associated Security Groups

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable Security Group Rule creation |
| security_group_id | ID of the Security Group |
| ingress_rules | List of ingress rule configurations |
| egress_rules | List of egress rule configurations |

---

## Outputs

| Name | Description |
|------|-------------|
| ingress_cidr_rule_ids | IDs of CIDR-based ingress rules |
| ingress_security_group_rule_ids | IDs of Security Group-based ingress rules |
| egress_rule_ids | IDs of egress rules |

---

## Example Usage

```hcl
module "alb_security_group_rule" {
  source = "../../modules/security-group/security-group-rule"

  enabled           = var.alb_enabled
  security_group_id = module.alb_security_group.security_group_id

  ingress_rules = [
    {
      description     = "Allow HTTP"
      port            = 80
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }
  ]

  egress_rules = [
    {
      description = "Allow all outbound traffic"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
```

---

## Supported Ingress Types

### CIDR-based Rules

Allows traffic from a CIDR block.

Example:

```hcl
cidr_blocks = ["0.0.0.0/0"]
```

### Security Group-based Rules

Allows traffic only from another Security Group.

Example:

```hcl
security_groups = [
  module.alb_security_group.security_group_id
]
```

This is commonly used for secure communication between AWS resources such as:

- ALB → ECS
- ALB → EC2
- ECS → RDS
- EC2 → RDS

---

## Security Benefits

- Supports the principle of least privilege.
- Enables secure communication between AWS resources.
- Reduces unnecessary network exposure.
- Allows traffic only from trusted CIDR blocks or Security Groups.
- Improves maintainability by separating rules from Security Groups.

---

## Related Modules

- security-group
- vpc
- alb
- rds
- ecs

---

## Notes

- This module creates only Security Group Rules.
- A Security Group must already exist before using this module.
- Supports both CIDR-based and Security Group-based ingress rules.
- Supports multiple ingress and egress rules.
- The module follows a reusable and environment-independent Terraform design.