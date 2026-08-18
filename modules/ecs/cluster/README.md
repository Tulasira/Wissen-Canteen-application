# ECS Cluster Module

## Overview

This module creates an Amazon ECS Cluster that serves as the logical grouping for running containerized applications.

The cluster is designed for AWS Fargate, allowing containers to run without managing EC2 instances.

---

## Architecture Flow

```text
Amazon ECS
     ↓
ECS Cluster
     ↓
Fargate Tasks
     ↓
Containers
```

---

## Resources Created

- aws_ecs_cluster

---

## Features

- Fargate compatible
- Environment-based naming
- Reusable Terraform module
- Common tagging strategy
- Independent infrastructure component

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable ECS Cluster creation |
| project_name | Project name used for naming |
| environment | Environment name (dev, qa, prod) |
| tags | Common tags |

---

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | ECS Cluster ID |
| cluster_name | ECS Cluster Name |
| cluster_arn | ECS Cluster ARN |

---

## Example Usage

```hcl
module "ecs_cluster" {
  source = "../../modules/ecs/cluster"

  enabled      = true
  project_name = "vpc-alb-rds"
  environment  = "dev"

  tags = local.common_tags
}
```

---

## Notes

- This module creates only the ECS Cluster.
- ECS Services and Task Definitions are created separately.
- The cluster uses AWS Fargate as the compute engine.
- No EC2 instances are required.