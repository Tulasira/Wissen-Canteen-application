# RDS DB Monitoring Module

## Overview

This module provisions the IAM Role required for Amazon RDS Enhanced Monitoring using Terraform.

The module creates a dedicated IAM Role and attaches the AWS managed **AmazonRDSEnhancedMonitoringRole** policy. The generated IAM Role ARN is automatically passed to the RDS DB Instance module whenever Enhanced Monitoring is enabled.

The module supports both **Standard Monitoring** and **Enhanced Monitoring** without requiring any infrastructure redesign. By default, the project uses Standard Monitoring (`monitoring_interval = 0`).

---

## Purpose

Amazon RDS Enhanced Monitoring requires an IAM Role that allows RDS to publish operating system metrics to Amazon CloudWatch Logs.

This module:

- Creates a dedicated IAM Role for Enhanced Monitoring
- Attaches the AWS managed monitoring policy
- Automatically enables the role only when Enhanced Monitoring is configured
- Keeps Standard Monitoring as the default behavior

---

## Architecture Flow

```text
Terraform
      │
      ▼
monitoring_interval
      │
      ▼
RDS DB Monitoring Module
      │
      ▼
IAM Role
      │
      ▼
AmazonRDSEnhancedMonitoringRole Policy
      │
      ▼
Amazon RDS
      │
      ▼
CloudWatch Logs
```

---

## Resources Created

- `aws_iam_role`
- `aws_iam_role_policy_attachment`

---

## Features

- Dedicated IAM Role for RDS Enhanced Monitoring
- Uses AWS managed IAM policy
- Automatically created only when required
- Supports Standard and Enhanced Monitoring
- Environment-based naming
- Common tagging strategy
- Reusable Terraform module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable IAM Role creation |
| project_name | Project name |
| environment | Environment name |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| monitoring_role_arn | ARN of the IAM Role used for Enhanced Monitoring |

---

## Example Usage

```hcl
module "db_monitoring" {
  source = "../../modules/rds/db-monitoring"

  enabled      = var.monitoring_interval > 0
  project_name = var.project_name
  environment  = var.environment

  tags = local.common_tags
}
```

---

## Monitoring Modes

### Standard Monitoring

```hcl
monitoring_interval = 0
```

- Uses default Amazon CloudWatch metrics.
- No IAM Role is created.
- No Enhanced Monitoring charges apply.

### Enhanced Monitoring

```hcl
monitoring_interval = 60
```

or

```hcl
monitoring_interval = 30
```

- Creates the IAM Role automatically.
- Attaches the `AmazonRDSEnhancedMonitoringRole` managed policy.
- Publishes operating system metrics to CloudWatch Logs.

---

## Current Development Configuration

```hcl
monitoring_interval = 0
```

The current deployment uses **Standard Monitoring**, so this module is not created.

---

## Security Benefits

- Uses a dedicated IAM Role for monitoring.
- Uses an AWS managed IAM policy instead of custom permissions.
- Follows the principle of least privilege.
- Enables secure communication between Amazon RDS and CloudWatch Logs.
- IAM Role is created only when Enhanced Monitoring is enabled.

---

## Related Modules

- db-instance
- db-subnet-group
- db-parameter-group
- db-option-group

---

## Notes

- This module creates only the IAM Role required for Amazon RDS Enhanced Monitoring.
- It does not create an RDS DB Instance.
- The generated IAM Role ARN is passed to the `db-instance` module through the `monitoring_role_arn` input.
- Standard Monitoring is used when `monitoring_interval = 0`.
- Enhanced Monitoring is enabled by setting `monitoring_interval` to a value greater than `0`.
- The AWS managed `AmazonRDSEnhancedMonitoringRole` policy is used instead of a custom IAM policy.
- The module follows a reusable and environment-independent Terraform design.