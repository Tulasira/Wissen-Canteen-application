# ECS CloudWatch Alarm Module

## Overview

This module creates Amazon CloudWatch alarms for an ECS Service.

It monitors CPU and memory utilization and triggers an alarm when the configured utilization threshold is exceeded.

---

## Architecture Flow

```text
Amazon ECS
     ↓
ECS Cluster
     ↓
ECS Service
     ↓
CloudWatch Metrics
     ↓
CPU / Memory Alarms
     ↓
Alarm State
````

---

## Resources Created

* `aws_cloudwatch_metric_alarm` for ECS CPU utilization
* `aws_cloudwatch_metric_alarm` for ECS Memory utilization

---

## Features

* ECS CPU utilization monitoring
* ECS Memory utilization monitoring
* Configurable CPU threshold
* Configurable Memory threshold
* Configurable evaluation periods
* Enable or disable alarms
* Environment-based alarm naming
* Common tagging strategy
* Independent infrastructure component

---

## Inputs

| Name               | Description                                |
| ------------------ | ------------------------------------------ |
| `enabled`          | Enable or disable CloudWatch alarms        |
| `project_name`     | Project name used for naming               |
| `environment`      | Environment name (dev, qa, prod)           |
| `cluster_name`     | ECS Cluster name                           |
| `service_name`     | ECS Service name                           |
| `cpu_threshold`    | CPU utilization threshold for the alarm    |
| `memory_threshold` | Memory utilization threshold for the alarm |
| `tags`             | Common tags                                |

---

## Outputs

| Name               | Description                            |
| ------------------ | -------------------------------------- |
| `cpu_alarm_arn`    | ARN of the ECS CPU CloudWatch alarm    |
| `memory_alarm_arn` | ARN of the ECS Memory CloudWatch alarm |

---

## Example Usage

```hcl
module "ecs_cloudwatch_alarm" {
  source = "../../modules/ecs/cloudwatch-alarm"

  enabled      = true
  project_name = "vpc-alb-rds"
  environment  = "dev"

  cluster_name = module.ecs_cluster.cluster_name
  service_name = module.ecs_service.service_name

  cpu_threshold    = 80
  memory_threshold = 80

  tags = local.common_tags
}
```

---

## Alarm Configuration

### CPU Alarm

The CPU alarm monitors the `CPUUtilization` metric from the `AWS/ECS` namespace.

The alarm is triggered when CPU utilization is greater than the configured `cpu_threshold` for 2 consecutive evaluation periods.

The metric is evaluated every 5 minutes using the `Average` statistic.

### Memory Alarm

The Memory alarm monitors the `MemoryUtilization` metric from the `AWS/ECS` namespace.

The alarm is triggered when memory utilization is greater than the configured `memory_threshold` for 2 consecutive evaluation periods.

The metric is evaluated every 5 minutes using the `Average` statistic.

---

## Notes

* This module creates CloudWatch alarms for an existing ECS Service.
* The ECS Cluster and ECS Service are created separately.
* CPU and Memory alarms are configured independently.
* The alarms use the ECS Cluster and Service name as metric dimensions.
* Missing metric data is treated as `notBreaching`.
* Setting `enabled = false` disables the CloudWatch alarm resources.
