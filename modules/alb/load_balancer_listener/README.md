# Load Balancer Listener Module

## Overview

This module provisions one or more Application Load Balancer (ALB) Listeners using a reusable and configurable Terraform module.

Listeners define how the Application Load Balancer receives incoming requests by specifying the listening port, protocol, and default action.

The module supports creating multiple listeners through a configurable map, making it reusable across different environments and applications.

---

## Architecture Flow

```
                 Internet
                     │
                     ▼
        Application Load Balancer
                     │
        ┌────────────┴────────────┐
        ▼                         ▼
 HTTP Listener               HTTPS Listener
 (Port 80)                  (Port 443)
        │                         │
        ▼                         ▼
 Default Action             Default Action
        │                         │
        ▼                         ▼
 Fixed Response / Forward to Target Group
```

---

## Resources Created

### ALB Listener(s)

Creates one or more Application Load Balancer Listeners attached to the specified ALB.

Each listener can independently define:

- Port
- Protocol
- Default Action
- Fixed Response Configuration

---

## Features

- Supports multiple listeners
- Configurable listener ports
- HTTP and HTTPS protocol support
- Fixed response configuration
- Environment-independent reusable design
- Integration with Application Load Balancer
- Map-based listener configuration

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable listener creation |
| load_balancer_arn | ARN of the Application Load Balancer |
| listeners | Map containing listener configuration |

---

## Listener Configuration

Each listener supports:

- Port
- Protocol
- Default Action Type
- Response Content Type
- Response Message
- HTTP Status Code

Example:

```hcl
listeners = {
  http = {
    port                = 80
    protocol            = "HTTP"
    default_action_type = "fixed-response"
    content_type        = "text/plain"
    message_body        = "ALB is running."
    status_code         = "200"
  }
}
```

---

## Outputs

| Name | Description |
|------|-------------|
| listener_arns | Map of created Listener ARNs |

---

## Example Usage

```hcl
module "load_balancer_listener" {
  source = "../../modules/alb/load_balancer_listener"

  enabled           = true
  load_balancer_arn = module.load_balancer.alb_arn

  listeners = {
    http = {
      port                = 80
      protocol            = "HTTP"
      default_action_type = "fixed-response"
      content_type        = "text/plain"
      message_body        = "ALB is running successfully."
      status_code         = "200"
    }
  }
}
```

---

## Current Behavior

The module currently supports configurable fixed-response listeners.

Each listener returns:

- Configurable Protocol
- Configurable Port
- Configurable HTTP Status Code
- Configurable Content Type
- Configurable Response Message

This is useful during infrastructure validation before backend applications are deployed.

---

## Future Enhancements

The module can be extended to support:

- Forward actions to Target Groups
- HTTPS with ACM certificates
- HTTP to HTTPS redirection
- Authentication actions
- Weighted Target Groups
- Lambda Targets
- Additional listener actions

---

## Related Modules

- load_balancer
- target_group
- load_balancer_listener_rule
- target_group_attachment

---

## Notes

- A listener must be attached to a valid Application Load Balancer.
- Multiple listeners can be created using the `listeners` variable.
- Listener routing logic is handled separately by the `load_balancer_listener_rule` module.
- Backend traffic forwarding can be configured using Target Groups and Target Group Attachments.