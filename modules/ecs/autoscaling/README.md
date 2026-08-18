# ECS Auto Scaling Module

## Overview

This module configures Auto Scaling for an Amazon ECS Service.

It allows the number of ECS tasks to automatically increase or decrease based on CPU and memory utilization.

---

## Architecture Flow

```text
Amazon ECS
     ↓
ECS Cluster
     ↓
ECS Service
     ↓
Auto Scaling Target
     ↓
CPU / Memory Scaling Policies
     ↓
ECS Tasks
````

---

## Resources Created

* `aws_appautoscaling_target`
* `aws_appautoscaling_policy` for CPU scaling
* `aws_appautoscaling_policy` for Memory scaling

---

## Features

* CPU-based Auto Scaling
* Memory-based Auto Scaling
* Configurable minimum task count
* Configurable maximum task count
* Enable or disable Auto Scaling
* Reusable Terraform module
* Independent infrastructure component

---

## Inputs

| Name                  | Description                          |
| --------------------- | ------------------------------------ |
| `enabled`             | Enable or disable ECS Auto Scaling   |
| `cluster_name`        | Name of the ECS Cluster              |
| `service_name`        | Name of the ECS Service              |
| `min_capacity`        | Minimum number of ECS tasks          |
| `max_capacity`        | Maximum number of ECS tasks          |
| `cpu_target_value`    | Target CPU utilization percentage    |
| `memory_target_value` | Target Memory utilization percentage |

---

## Outputs

| Name                        | Description                  |
| --------------------------- | ---------------------------- |
| `resource_id`               | ECS Auto Scaling Resource ID |
| `cpu_scaling_policy_arn`    | CPU Scaling Policy ARN       |
| `memory_scaling_policy_arn` | Memory Scaling Policy ARN    |

---

## Example Usage

```hcl
module "ecs_auto_scaling" {
  source = "../../modules/ecs/auto-scaling"

  enabled      = true
  cluster_name = module.ecs_cluster.cluster_name
  service_name = module.ecs_service.service_name

  min_capacity = 1
  max_capacity = 3

  cpu_target_value    = 70
  memory_target_value = 70
}
```

---

## Notes

* This module configures Auto Scaling for an existing ECS Service.
* The ECS Cluster and ECS Service are created separately.
* CPU and memory scaling policies are configured independently.
* The minimum and maximum task count controls the scaling range.
* Setting `enabled = false` disables the Auto Scaling resources.