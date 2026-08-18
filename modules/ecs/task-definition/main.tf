resource "aws_ecs_task_definition" "this" {
  count = var.enabled ? 1 : 0

  family = "${var.project_name}-${var.environment}"

  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]

  cpu    = var.cpu
  memory = var.memory

  execution_role_arn = var.task_execution_role_arn
  task_role_arn      = var.task_role_arn

  runtime_platform {

    operating_system_family = var.operating_system_family

    cpu_architecture = var.cpu_architecture

  }

  container_definitions = jsonencode([
    {
      name  = var.container_name
      image = var.container_image

      essential = true

      readonlyRootFilesystem = var.readonly_root_filesystem

      linuxParameters = {
        initProcessEnabled = var.linux_init_process_enabled
      }

      healthCheck = var.ecs_health_check_enabled ? {
        command     = var.ecs_health_check_command
        interval    = var.ecs_health_check_interval
        timeout     = var.ecs_health_check_timeout
        retries     = var.ecs_health_check_retries
        startPeriod = var.ecs_health_check_start_period
      } : null

      environment = var.environment_variables
      secrets     = var.container_secrets

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = var.log_group_name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-task-definition"
    }
  )
}