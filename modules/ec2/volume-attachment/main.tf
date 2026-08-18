resource "aws_volume_attachment" "this" {

  count = var.enabled ? 1 : 0

  device_name = var.device_name

  volume_id = var.volume_id

  instance_id = var.instance_id

  force_detach = var.force_detach

  skip_destroy = var.skip_destroy

}