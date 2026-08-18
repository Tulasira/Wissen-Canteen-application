# ECS Task Execution Role Module

## Overview

This module creates the IAM Role required by ECS Fargate tasks.

The execution role allows ECS to pull images from Amazon ECR and send logs to Amazon CloudWatch.

---

## Architecture Flow

```text
ECS Task
    ↓
IAM Execution Role
    ↓
AWS Managed Policy
    ↓
ECR + CloudWatch Logs
```

---

## Resources Created

- aws_iam_role
- aws_iam_role_policy_attachment

---

## Features

- Fargate compatible
- Uses AWS managed ECS execution policy
- Supports ECR image pulling
- Supports CloudWatch logging
- Environment-based naming
- Reusable module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable role creation |
| project_name | Project name |
| environment | Environment name |
| tags | Common tags |

---

## Outputs

| Name | Description |
|------|-------------|
| execution_role_arn | IAM Role ARN |
| execution_role_name | IAM Role Name |

---

## Example Usage

```hcl
module "ecs_task_execution_role" {
  source = "../../modules/ecs/task-execution-role"

  enabled      = true
  project_name = "vpc-alb-rds"
  environment  = "dev"

  tags = local.common_tags
}
```

---

## Notes

- This role is mandatory for AWS Fargate tasks.
- It is different from the Task Role.
- AWS automatically uses this role for pulling images and writing logs.