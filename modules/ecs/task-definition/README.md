# ECS Task Definition Module

## Overview

This module creates an ECS Task Definition for AWS Fargate.

The task definition specifies the container image, CPU, memory, port mappings, logging configuration, and execution role.

---

## Architecture Flow

```text
ECS Task Definition
        ↓
Container Image
        ↓
CPU + Memory
        ↓
CloudWatch Logs
        ↓
Fargate Task
```

---

## Resources Created

- aws_ecs_task_definition

---

## Features

- AWS Fargate compatible
- Configurable CPU and memory
- CloudWatch logging integration
- Environment-based naming
- Container port mapping
- Reusable module

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable Task Definition creation |
| project_name | Project name |
| environment | Environment name |
| task_execution_role_arn | ECS Execution Role ARN |
| container_name | Container name |
| container_image | Docker image |
| container_port | Container port |
| cpu | Fargate CPU |
| memory | Fargate memory |
| log_group_name | CloudWatch Log Group |
| aws_region | AWS Region |
| tags | Common tags |

---

## Outputs

| Name | Description |
|------|-------------|
| task_definition_arn | ECS Task Definition ARN |
| task_definition_family | ECS Task Definition Family |

---

## Example Usage

```hcl
module "ecs_task_definition" {
  source = "../../modules/ecs/task-definition"

  enabled      = true
  project_name = "vpc-alb-rds"
  environment  = "dev"

  task_execution_role_arn = module.ecs_task_execution_role.execution_role_arn

  container_name  = "nginx"
  container_image = "nginx:latest"
  container_port  = 80

  cpu    = 256
  memory = 512

  log_group_name = module.ecs_log_group.log_group_name
  aws_region     = "us-east-2"

  tags = local.common_tags
}
```

---

## Notes

- This module creates only the Task Definition.
- AWS Fargate launch type is used.
- CloudWatch logging is enabled.
- CPU and memory values must follow Fargate supported combinations.