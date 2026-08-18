resource "aws_ecs_service" "this" {
  count = var.enabled ? 1 : 0

  name            = "${var.project_name}-${var.environment}-service"
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count

  #########################################
  # Capacity Provider Strategy
  #########################################

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = local.fargate_weight
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = local.fargate_spot_weight
  }

  #########################################
  # Deployment Configuration
  #########################################

  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent

  deployment_controller {
    type = "ECS"
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  #########################################
  # ECS Execute Command
  #########################################

  enable_execute_command = var.enable_execute_command

  #########################################
  # Platform
  #########################################

  platform_version                  = var.platform_version
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  #########################################
  # Network
  #########################################

  network_configuration {
    subnets          = var.private_app_subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  #########################################
  # Load Balancer
  #########################################

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  #########################################
  # Tags
  #########################################

  propagate_tags = var.propagate_tags

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-service"
    }
  )

  #########################################
  # Lifecycle
  #########################################

  lifecycle {
    ignore_changes = [
      desired_count
    ]
  }
}