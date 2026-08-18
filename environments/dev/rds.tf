module "rds_security_group" {
  source = "../../modules/security-group/security-group"

  enabled                    = var.rds_enabled
  security_group_name        = "${var.project_name}-${var.environment}-rds-sg"
  security_group_description = "Security group for RDS"
  vpc_id                     = module.vpc.vpc_id

  tags = local.common_tags
}

module "rds_security_group_rule" {
  source = "../../modules/security-group/security-group-rule"

  enabled           = var.rds_enabled
  security_group_id = module.rds_security_group.security_group_id

  ingress_rules = [
    {
      description     = "Allow database access from ALB security group"
      port            = var.db_port
      security_groups = [module.alb_security_group.security_group_id]
      cidr_blocks     = []
    }
  ]

  egress_rules = [
    {
      description = "Allow all outbound traffic"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "db_subnet_group" {
  source = "../../modules/rds/db-subnet-group"

  enabled       = var.rds_enabled
  project_name  = var.project_name
  environment   = var.environment
  db_subnet_ids = module.subnets.db_subnet_ids

  tags = local.common_tags
}

module "db_parameter_group" {
  source = "../../modules/rds/db_parameter-group"

  enabled                = var.rds_enabled
  project_name           = var.project_name
  environment            = var.environment
  parameter_group_family = var.parameter_group_family
  db_parameters          = var.db_parameters

  tags = local.common_tags
}

module "db_option_group" {
  source = "../../modules/rds/db_option-group"

  enabled                  = var.rds_enabled
  project_name             = var.project_name
  environment              = var.environment
  option_group_engine_name = var.option_group_engine_name
  major_engine_version     = var.major_engine_version
  db_options               = var.db_options

  tags = local.common_tags
}

module "db_monitoring" {
  source = "../../modules/rds/db-monitoring"

  # Creates IAM role only when Enhanced Monitoring is enabled
  enabled      = var.monitoring_interval > 0
  project_name = var.project_name
  environment  = var.environment

  tags = local.common_tags
}

module "db_instance" {
  source = "../../modules/rds/db-instance"

  enabled      = var.rds_enabled
  project_name = var.project_name
  environment  = var.environment

  db_subnet_group_name = module.db_subnet_group.db_subnet_group_name
  security_group_ids   = [module.rds_security_group.security_group_id]
  parameter_group_name = module.db_parameter_group.parameter_group_name
  option_group_name    = module.db_option_group.option_group_name

  db_name          = var.db_name
  db_secret_string = module.secrets_manager.secret_string

  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  allocated_storage = var.db_allocated_storage
  storage_type      = var.db_storage_type
  multi_az          = var.db_multi_az

  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period

  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = module.db_monitoring.monitoring_role_arn

  deletion_protection     = var.db_deletion_protection
  skip_final_snapshot     = var.db_skip_final_snapshot
  backup_retention_period = var.db_backup_retention_period

  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window

  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  tags = local.common_tags
}