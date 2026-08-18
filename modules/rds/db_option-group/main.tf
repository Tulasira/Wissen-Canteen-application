resource "aws_db_option_group" "this" {
  count = var.enabled ? 1 : 0

  name                 = "${var.project_name}-${var.environment}-mysql-option-group"
  engine_name          = var.option_group_engine_name
  major_engine_version = var.major_engine_version

  dynamic "option" {
    for_each = var.db_options

    content {
      option_name = option.value.option_name

      dynamic "option_settings" {
        for_each = option.value.option_settings

        content {
          name  = option_settings.value.name
          value = option_settings.value.value
        }
      }
    }
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-mysql-option-group"
  })
}