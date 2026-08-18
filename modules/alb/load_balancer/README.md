# Load Balancer Module

## Overview

This module provisions an AWS Application Load Balancer (ALB) using a reusable and configurable Terraform module.

It supports both Internet-facing and Internal ALBs, configurable subnet selection, deployment across a configurable number of Availability Zones (AZs), and integrates with separate Target Group, Listener, and Listener Rule modules.

---

## Architecture Flow

```
                    Internet
                        │
                        ▼
          Application Load Balancer
                        │
                Security Group
                        │
                        ▼
                 Listener(s)
                        │
                        ▼
               Listener Rule(s)
                        │
                        ▼
                 Target Group(s)
                        │
                        ▼
              Backend Application
```

---

## Features

- Internet-facing or Internal ALB
- Automatic subnet selection
  - Public Subnets for Internet-facing ALB
  - Private App Subnets for Internal ALB
- Configurable number of Availability Zones
- Multi-AZ deployment
- Security Group integration
- Deletion protection support
- Environment-based naming
- Common tagging strategy
- Supports multiple listeners
- Supports multiple listener rules
- Modular Terraform design

---

## Resources Created

### Application Load Balancer

Creates an AWS Application Load Balancer.

The ALB automatically deploys into the appropriate subnet type based on the value of `internal`.

- Internet-facing → Public Subnets
- Internal → Private App Subnets

The number of subnets used for deployment is configurable.

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable ALB creation |
| project_name | Project name used for naming |
| environment | Environment name |
| public_subnet_ids | List of subnet IDs selected for ALB deployment |
| security_group_ids | Security Groups attached to ALB |
| internal | Deploy Internet-facing or Internal ALB |
| enable_deletion_protection | Enable deletion protection |
| tags | Resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| alb_arn | ARN of the Application Load Balancer |
| alb_dns_name | DNS name of the Application Load Balancer |

---

## Example Usage

```hcl
module "load_balancer" {
  source = "../../modules/alb/load_balancer"

  enabled      = true
  project_name = "vpc-alb-rds"
  environment  = "dev"

  public_subnet_ids = slice(
    var.alb_internal
      ? module.subnets.private_app_subnet_ids
      : module.subnets.public_subnet_ids,
    0,
    var.alb_subnet_count
  )

  security_group_ids = [
    module.alb_security_group.security_group_id
  ]

  internal                   = var.alb_internal
  enable_deletion_protection = var.alb_enable_deletion_protection

  tags = local.common_tags
}
```

---

## Deployment Behavior

### Internet-facing ALB

- Deploys into Public Subnets
- Accessible from the Internet
- Typically used for public applications

### Internal ALB

- Deploys into Private App Subnets
- Accessible only within the VPC
- Used for internal services and microservices

---

## Availability Zone Selection

The module supports configurable deployment across multiple Availability Zones.

Example:

```hcl
alb_subnet_count = 2
```

Deploys the ALB into the first two selected subnets.

Increasing this value allows deployment across additional Availability Zones without changing the module.

---

## Listener Support

Listener configuration is handled separately through the `load_balancer_listener` module.

The module supports creating multiple listeners using a configurable map.

Example:

- HTTP (80)
- HTTPS (443)
- Additional custom listeners

---

## Listener Rule Support

Listener Rules are managed through the `load_balancer_listener_rule` module.

Multiple routing rules can be created using a configurable map.

Example:

- Path-based routing
- Prefix matching
- Multiple priorities

---

## Related Modules

- target_group
- load_balancer_listener
- load_balancer_listener_rule
- target_group_attachment

---

## Security Benefits

- Access controlled using Security Groups
- Supports Internal ALB for private workloads
- Separation of networking and listener configuration
- High availability across multiple Availability Zones
- Modular and reusable design
- Centralized application entry point

---

## Notes

- AWS requires an ALB to be deployed in at least two subnets located in different Availability Zones.
- Internet-facing ALBs should use Public Subnets.
- Internal ALBs should use Private App Subnets.
- Listener configuration is managed by the `load_balancer_listener` module.
- Listener Rules are managed by the `load_balancer_listener_rule` module.
- Backend target registration is managed by the `target_group_attachment` module.