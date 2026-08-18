# ECS Service Module

## Overview

This module creates an ECS Service that runs containerized applications on AWS Fargate.

The service maintains the desired number of running tasks and integrates with an Application Load Balancer.

---

## Architecture Flow

```text
Internet
    ↓
Application Load Balancer
    ↓
Target Group
    ↓
ECS Service
    ↓
Fargate Tasks
    ↓
Containers
```

---

## Resources Created

- aws_ecs_service

---

## Features

- AWS Fargate support
- ALB integration
- Desired task count management
- Private subnet deployment
- Environment-based naming
- Reusable module
- Common tagging strategy

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable ECS Service creation |
| project_name | Project name |
| environment | Environment name |
| cluster_id | ECS Cluster ID |
| task_definition_arn | Task Definition ARN |
| desired_count | Number of tasks |
| subnet_ids | Private application subnet IDs |
| security_group_ids | Security Group IDs |
| target_group_arn | ALB Target Group ARN |
| container_name | Container name |
| container_port | Container port |
| assign_public_ip | Assign public IP to tasks |
| tags | Common tags |

---

## Outputs

| Name | Description |
|------|-------------|
| service_name | ECS Service Name |
| service_arn | ECS Service ARN |

---

## Example Usage

```hcl
module "ecs_service" {
  source = "../../modules/ecs/service"

  enabled      = true
  project_name = "vpc-alb-rds"
  environment  = "dev"

  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = module.ecs_task_definition.task_definition_arn

  desired_count = 1

  subnet_ids = module.subnets.private_app_subnet_ids

  security_group_ids = [
    module.alb_security_group.security_group_id
  ]

  target_group_arn = module.target_group.target_group_arn

  container_name = "nginx"
  container_port = 80

  assign_public_ip = false

  tags = local.common_tags
}
```

---

## Notes

- ECS tasks run inside private application subnets.
- AWS Fargate is used as the launch type.
- The Application Load Balancer routes traffic to ECS tasks.
- Desired task count is automatically maintained by ECS.
- Public IP assignment is disabled for security purposes.