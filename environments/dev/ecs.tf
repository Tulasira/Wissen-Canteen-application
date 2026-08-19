####################################
# ECS Cluster
####################################

module "ecs_cluster" {
  source = "../../modules/ecs/cluster"

  enabled      = var.ecs_enabled
  project_name = var.project_name
  environment  = var.environment

  tags = local.common_tags
}


####################################
# ECS Log Group
####################################

module "ecs_log_group" {
  source = "../../modules/ecs/log-group"

  enabled      = var.ecs_enabled
  project_name = var.project_name
  environment  = var.environment

  retention_in_days = var.ecs_log_retention_days

  tags = local.common_tags
}


####################################
# ECS Task Execution Role
####################################

module "ecs_task_execution_role" {
  source = "../../modules/ecs/task-execution-role"

  enabled      = var.ecs_enabled
  project_name = var.project_name
  environment  = var.environment

  tags = local.common_tags
}


####################################
# ECS Task Definition
####################################

module "ecs_task_definition" {
  source = "../../modules/ecs/task-definition"

  enabled      = var.ecs_enabled
  project_name = var.project_name
  environment  = var.environment

  task_execution_role_arn = module.ecs_task_execution_role.task_execution_role_arn

  task_role_arn = module.iam.task_role_arn

  container_name  = var.container_name
  container_image = var.container_image
  container_port  = var.container_port

  cpu                     = var.ecs_cpu
  memory                  = var.ecs_memory
  operating_system_family = var.operating_system_family
  cpu_architecture        = var.cpu_architecture

  readonly_root_filesystem   = var.readonly_root_filesystem
  linux_init_process_enabled = var.linux_init_process_enabled

  environment_variables         = var.environment_variables
  ecs_health_check_enabled      = var.ecs_health_check_enabled
  ecs_health_check_command      = var.ecs_health_check_command
  ecs_health_check_interval     = var.ecs_health_check_interval
  ecs_health_check_timeout      = var.ecs_health_check_timeout
  ecs_health_check_retries      = var.ecs_health_check_retries
  ecs_health_check_start_period = var.ecs_health_check_start_period

  container_secrets = [

    {
      name = "DB_USERNAME"

      valueFrom = "${module.secrets_manager.secret_arn}:username::"
    },

    {
      name = "DB_PASSWORD"

      valueFrom = "${module.secrets_manager.secret_arn}:password::"
    }

  ]

  log_group_name = module.ecs_log_group.log_group_name
  aws_region     = var.aws_region

  tags = local.common_tags
}


####################################
# ECS Service
####################################

module "ecs_service" {
  source = "../../modules/ecs/service"

  enabled      = var.ecs_enabled
  project_name = var.project_name
  environment  = var.environment

  cluster_id              = module.ecs_cluster.cluster_id
  task_definition_arn     = module.ecs_task_definition.task_definition_arn
  fargate_spot_percentage = var.fargate_spot_percentage

  desired_count = var.desired_count

  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent

  deployment_maximum_percent = var.deployment_maximum_percent

  platform_version = var.platform_version

  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  enable_execute_command = var.enable_execute_command

  propagate_tags = var.propagate_tags

  private_app_subnet_ids = module.subnets.private_app_subnet_ids

  security_group_ids = [
    module.alb_security_group.security_group_id
  ]

  target_group_arn = module.target_group.target_group_arn

  container_name = var.container_name
  container_port = var.container_port

  assign_public_ip = false

  tags = local.common_tags
}

####################################
# ECS CloudWatch Alarms
####################################

module "ecs_cloudwatch_alarms" {
  source = "../../modules/ecs/cloudwatch-alarm"

  enabled = var.ecs_enabled

  project_name = var.project_name
  environment  = var.environment

  cluster_name = module.ecs_cluster.cluster_name

  service_name = module.ecs_service.service_name

  cpu_threshold = var.ecs_cpu_alarm_threshold

  memory_threshold = var.ecs_memory_alarm_threshold

  tags = local.common_tags
}

####################################
# ECS Auto Scaling
####################################

module "ecs_auto_scaling" {
  source = "../../modules/ecs/autoscaling"

  enabled      = var.ecs_enabled
  project_name = var.project_name
  environment  = var.environment

  #########################################
  # ECS
  #########################################

  cluster_name = "${var.project_name}-${var.environment}-ecs-cluster"

  service_name = "${var.project_name}-${var.environment}-service"

  #########################################
  # Capacity
  #########################################

  min_capacity = var.min_capacity

  max_capacity = var.max_capacity

  #########################################
  # CPU Scaling
  #########################################

  cpu_target_value = var.cpu_target_value

  #########################################
  # Memory Scaling
  #########################################

  memory_target_value = var.memory_target_value

  #########################################
  # Cooldown
  #########################################

  scale_in_cooldown = var.scale_in_cooldown

  scale_out_cooldown = var.scale_out_cooldown
}