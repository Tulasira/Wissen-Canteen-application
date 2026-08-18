# Target Group Module

## Overview

This module provisions an AWS Application Load Balancer (ALB) Target Group using a reusable and configurable Terraform module.

A Target Group acts as the destination for traffic received from an Application Load Balancer Listener. It forwards incoming requests to registered backend targets such as EC2 instances, ECS tasks, IP addresses, or Lambda functions.

The module also provides fully configurable health check settings to continuously monitor target availability.

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
                    ▼
              Target Group
                    │
      ┌─────────────┴─────────────┐
      ▼                           ▼
 EC2 Instances              ECS Tasks
      │                           │
      └─────────────┬─────────────┘
                    ▼
          Application Traffic
```

---

## Resources Created

### Target Group

Creates an Application Load Balancer Target Group within the specified VPC.

The Target Group receives requests from the ALB Listener and forwards traffic to registered backend targets.

### Health Check Configuration

Creates configurable health checks that continuously monitor backend target availability and automatically remove unhealthy targets from load balancing.

---

## Features

- Configurable Target Group protocol
- Configurable Target Group port
- Configurable target type
- Configurable health check settings
- Environment-based naming
- VPC integration
- Standard tagging strategy
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable Target Group creation |
| project_name | Project name used for naming |
| environment | Environment name |
| vpc_id | VPC where the Target Group will be created |
| target_group_port | Port used by backend targets |
| target_group_protocol | Protocol used by the Target Group |
| target_type | Backend target type (instance, ip, lambda) |
| health_check_enabled | Enable or disable health checks |
| health_check_protocol | Health check protocol |
| health_check_path | Endpoint used for health checks |
| health_check_matcher | Expected HTTP response code |
| health_check_interval | Health check interval in seconds |
| health_check_timeout | Health check timeout in seconds |
| healthy_threshold | Successful checks required before a target becomes healthy |
| unhealthy_threshold | Failed checks required before a target becomes unhealthy |
| tags | Resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| target_group_arn | ARN of the Target Group |
| target_group_name | Name of the Target Group |
| target_group_id | ID of the Target Group |

---

## Example Usage

```hcl
module "target_group" {
  source = "../../modules/alb/target_group"

  enabled      = true
  project_name = "vpc-alb-rds"
  environment  = "dev"

  vpc_id = module.vpc.vpc_id

  target_group_port     = 80
  target_group_protocol = "HTTP"
  target_type           = "instance"

  health_check_enabled  = true
  health_check_protocol = "HTTP"
  health_check_path     = "/"
  health_check_matcher  = "200"

  health_check_interval = 30
  health_check_timeout  = 5

  healthy_threshold   = 2
  unhealthy_threshold = 3

  tags = local.common_tags
}
```

---

## Health Check Configuration

The module supports fully configurable health check settings.

Example configuration:

| Setting | Example Value |
|----------|---------------|
| Enabled | true |
| Protocol | HTTP |
| Path | / |
| Matcher | 200 |
| Interval | 30 Seconds |
| Timeout | 5 Seconds |
| Healthy Threshold | 2 |
| Unhealthy Threshold | 3 |

These values can be customized for different environments without modifying the module code.

---

## Supported Target Types

The module supports:

- EC2 Instances
- ECS Services
- IP Addresses
- Lambda Functions

---

## Future Enhancements

The module can be extended to support:

- HTTPS Target Groups
- gRPC Target Groups
- Sticky Sessions
- Slow Start
- Deregistration Delay
- Weighted Target Groups
- Target Group Attachments

---

## Related Modules

- load_balancer
- load_balancer_listener
- load_balancer_listener_rule
- target_group_attachment

---

## Notes

- A Target Group must belong to a VPC.
- A Listener forwards requests to a Target Group.
- Backend targets must be registered before application traffic can be served.
- Health checks are fully configurable through Terraform variables.
- This module creates only the Target Group; backend target registration is managed separately through the `target_group_attachment` module.