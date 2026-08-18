resource "aws_db_parameter_group" "this" {
  count = var.enabled ? 1 : 0

  name        = "${var.project_name}-${var.environment}-mysql-parameter-group"
  family      = var.parameter_group_family
  description = "Custom parameter group for ${var.project_name} ${var.environment} RDS"

  dynamic "parameter" {
    for_each = var.db_parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-mysql-parameter-group"
  })
}