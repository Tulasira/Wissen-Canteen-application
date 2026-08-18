locals {
  db_credentials = jsondecode(var.db_secret_string)
}

resource "aws_db_instance" "this" {
  count = var.enabled ? 1 : 0

  identifier = "${var.project_name}-${var.environment}-rds"

  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  db_name  = var.db_name
  username = local.db_credentials.username
  password = local.db_credentials.password

  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  storage_encrypted = true

  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.security_group_ids
  parameter_group_name   = var.parameter_group_name
  option_group_name      = var.option_group_name

  multi_az            = var.multi_az
  publicly_accessible = false

  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  performance_insights_enabled = var.performance_insights_enabled
  performance_insights_retention_period = (
    var.performance_insights_enabled ? var.performance_insights_retention_period : null
  )

  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_interval > 0 ? var.monitoring_role_arn : null

  deletion_protection        = var.deletion_protection
  skip_final_snapshot        = var.skip_final_snapshot
  backup_retention_period    = var.backup_retention_period
  backup_window              = var.preferred_backup_window
  maintenance_window         = var.preferred_maintenance_window
  copy_tags_to_snapshot      = true
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-rds"
  })
}