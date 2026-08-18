resource "aws_launch_template" "this" {

  count = var.enabled ? 1 : 0

  name_prefix = "${var.project_name}-${var.environment}-"

  image_id = var.ami_id

  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = var.security_group_ids

  ebs_optimized = var.ebs_optimized

  user_data = base64encode(var.user_data)

  update_default_version = true

  monitoring {
    enabled = var.monitoring_enabled
  }

  dynamic "iam_instance_profile" {

    for_each = var.iam_instance_profile == null ? [] : [1]

    content {
      name = var.iam_instance_profile
    }

  }

  block_device_mappings {

    device_name = "/dev/xvda"

    ebs {

      volume_size = var.volume_size

      volume_type = var.volume_type

      encrypted = var.encrypted

      delete_on_termination = var.delete_on_termination

    }

  }

  dynamic "instance_market_options" {

    for_each = var.spot_instance ? [1] : []

    content {

      market_type = "spot"

      spot_options {

        spot_instance_type = "one-time"

      }

    }

  }

  tag_specifications {

    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = "${var.project_name}-${var.environment}-ec2"
      }
    )

  }

}