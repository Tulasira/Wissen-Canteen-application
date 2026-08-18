resource "aws_instance" "this" {

  count = var.enabled ? 1 : 0

  subnet_id = var.subnet_id

  associate_public_ip_address = var.associate_public_ip_address

  disable_api_termination = var.disable_api_termination

  launch_template {

    id = var.launch_template_id

    version = var.launch_template_version

  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-ec2"
    }
  )

}