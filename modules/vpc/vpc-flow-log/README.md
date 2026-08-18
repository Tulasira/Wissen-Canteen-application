# VPC Flow Log Module

## Overview

This module provisions AWS VPC Flow Logs for a specified Virtual Private Cloud (VPC).

VPC Flow Logs capture information about IP traffic flowing to and from network interfaces within the VPC. The logs are published to Amazon CloudWatch Logs, enabling monitoring, troubleshooting, security analysis, and auditing.

The module automatically provisions the required CloudWatch Log Group, IAM Role, IAM Policy, and Flow Log resource.

---

## Purpose

This module provides a reusable way to enable network traffic logging for a VPC.

The module:

- Creates VPC Flow Logs
- Creates a CloudWatch Log Group
- Creates the required IAM Role
- Creates the required IAM Policy
- Publishes flow logs to CloudWatch Logs
- Supports configurable traffic types
- Supports configurable log retention
- Follows reusable Terraform design

---

## Architecture Flow

```text
                 VPC
                  │
                  ▼
            VPC Flow Logs
                  │
                  ▼
              IAM Role
                  │
                  ▼
             IAM Policy
                  │
                  ▼
      CloudWatch Log Group
                  │
                  ▼
        Amazon CloudWatch Logs
```

---

## Resources Created

- `aws_cloudwatch_log_group`
- `aws_iam_role`
- `aws_iam_role_policy`
- `aws_flow_log`

---

## Features

- Enables VPC Flow Logs
- CloudWatch Logs integration
- Automatic IAM Role creation
- Automatic IAM Policy creation
- Configurable traffic type (`ALL`, `ACCEPT`, `REJECT`)
- Configurable CloudWatch log retention
- Environment-based resource naming
- Common tagging strategy
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable VPC Flow Logs |
| project_name | Project name |
| environment | Environment name |
| vpc_id | Target VPC ID |
| traffic_type | Traffic to capture (`ALL`, `ACCEPT`, `REJECT`) |
| retention_in_days | CloudWatch Log retention period |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| flow_log_id | ID of the VPC Flow Log |
| flow_log_group_name | CloudWatch Log Group name |
| flow_log_role_arn | IAM Role ARN used by VPC Flow Logs |

---

## Example Usage

```hcl
module "vpc_flow_log" {
  source = "../../modules/vpc/vpc-flow-log"

  enabled           = var.enable_vpc_flow_logs
  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id

  traffic_type      = var.vpc_flow_log_traffic_type
  retention_in_days = var.vpc_flow_log_retention_in_days

  tags = local.common_tags
}
```

---

## Current Dev Configuration

```hcl
enable_vpc_flow_logs           = true
vpc_flow_log_traffic_type      = "ALL"
vpc_flow_log_retention_in_days = 7
```

---

## Security Benefits

- Captures network traffic entering and leaving the VPC.
- Helps identify unauthorized network activity.
- Supports security monitoring and incident investigation.
- Simplifies network troubleshooting.
- Provides audit logs for compliance requirements.
- Stores logs securely in Amazon CloudWatch Logs.

---

## Related Modules

- vpc
- subnets
- security-group
- nacl
- route_table
- route

---

## Notes

- This module creates only the VPC Flow Log infrastructure.
- It automatically provisions the required CloudWatch Log Group.
- It automatically creates the IAM Role and IAM Policy required by AWS VPC Flow Logs.
- Supported traffic types are `ALL`, `ACCEPT`, and `REJECT`.
- CloudWatch log retention can be configured through `terraform.tfvars`.
- The module follows a reusable and environment-independent Terraform design.