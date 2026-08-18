# Load Balancer Listener Rule Module

## Overview

This module provisions one or more Application Load Balancer (ALB) Listener Rules using a reusable Terraform module.

Listener Rules define how incoming requests are routed after reaching an ALB Listener. The module supports multiple listener rules through a configurable map, enabling path-based routing to backend Target Groups.

---

## Architecture Flow

```
                    Internet
                        │
                        ▼
          Application Load Balancer
                        │
                        ▼
                  ALB Listener
                        │
            ┌───────────┴───────────┐
            ▼                       ▼
      Listener Rule 1         Listener Rule 2
         /api/*                  /admin/*
            │                       │
            ▼                       ▼
             Target Group(s)
                    │
                    ▼
          Backend Application
```

---

## Resources Created

### ALB Listener Rule(s)

Creates one or more Listener Rules attached to an existing Application Load Balancer Listener.

Each rule evaluates incoming requests based on configured conditions and forwards matching traffic to the specified Target Group.

---

## Features

- Supports multiple listener rules
- Path-based routing
- Configurable rule priorities
- Map-based configuration using `for_each`
- Integration with ALB Listener module
- Integration with Target Group module
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable Listener Rule creation |
| listener_arns | Map of Listener ARNs created by the Listener module |
| target_group_arn | Target Group ARN where matching traffic is forwarded |
| listener_rules | Map containing Listener Rule configuration |

---

## Listener Rule Configuration

Each rule supports:

- Listener selection
- Rule priority
- Path patterns

Example:

```hcl
listener_rules = {
  app = {
    listener_key  = "http"
    priority      = 100
    path_patterns = ["/*"]
  }
}
```

---

## Outputs

| Name | Description |
|------|-------------|
| listener_rule_arns | Map of created Listener Rule ARNs |

---

## Example Usage

```hcl
module "load_balancer_listener_rule" {
  source = "../../modules/alb/load_balancer_listener_rule"

  enabled          = var.alb_enabled
  listener_arns    = module.load_balancer_listener.listener_arns
  target_group_arn = module.target_group.target_group_arn

  listener_rules = var.listener_rules
}
```

---

## Current Behavior

The module currently supports forwarding requests to a Target Group based on path pattern matching.

Example:

- `/*`
- `/api/*`
- `/admin/*`

Each rule is assigned a configurable priority to control routing order.

---

## Future Enhancements

The module can be extended to support:

- Host-based routing
- Header-based routing
- HTTP method matching
- Query string matching
- Source IP conditions
- Multiple Target Groups
- Weighted routing
- Authentication actions

---

## Related Modules

- load_balancer
- load_balancer_listener
- target_group
- target_group_attachment

---

## Notes

- Listener Rules require an existing ALB Listener.
- Rule priorities must be unique for each listener.
- Multiple Listener Rules can be created using the `listener_rules` variable.
- Requests matching the configured conditions are forwarded to the specified Target Group.
- This module currently supports path-based routing and can be extended to support additional routing conditions in the future.