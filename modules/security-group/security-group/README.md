# Security Group Module

## Overview

This module provisions an AWS Security Group using Terraform.

The module is responsible only for creating the Security Group resource. Security Group Rules are managed separately through the `security-group-rule` module to improve modularity, reusability, and maintainability.

This design allows the same Security Group to be reused with different ingress and egress rules across multiple AWS resources.

---

## Purpose

This module provides a reusable Security Group that can be attached to AWS resources such as:

- Application Load Balancer (ALB)
- Amazon RDS
- Amazon ECS
- Amazon EC2
- Other VPC resources

Separating the Security Group from its rules makes infrastructure easier to manage and extend.

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
      ▼
AWS Resources
(ALB / RDS / ECS / EC2)
```

---

## Resources Created

- `aws_security_group`

---

## Features

- Creates reusable AWS Security Groups
- Security Group Rules managed separately
- Environment-based resource naming
- Common tagging strategy
- Reusable Terraform module
- Supports multiple AWS services

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable Security Group creation |
| security_group_name | Name of the Security Group |
| security_group_description | Description of the Security Group |
| vpc_id | VPC where the Security Group will be created |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| security_group_id | ID of the Security Group |
| security_group_name | Name of the Security Group |

---

## Example Usage

```hcl
module "alb_security_group" {
  source = "../../modules/security-group/security-group"

  enabled                    = var.alb_enabled
  security_group_name        = "${var.project_name}-${var.environment}-alb-sg"
  security_group_description = "Security Group for Application Load Balancer"
  vpc_id                     = module.vpc.vpc_id

  tags = local.common_tags
}
```

---

## Security Benefits

- Provides logical network isolation.
- Can be reused across multiple AWS resources.
- Rules are managed separately to simplify maintenance.
- Follows the principle of least privilege by allowing only required traffic.

---

## Related Modules

- security-group-rule
- vpc
- alb
- rds
- ecs

---

## Notes

- This module creates only the Security Group.
- Ingress and egress rules are managed by the `security-group-rule` module.
- A Security Group must belong to a VPC.
- The module follows a reusable and environment-independent Terraform design.