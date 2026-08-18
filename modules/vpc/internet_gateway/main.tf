resource "aws_internet_gateway" "this" {
  count = var.enabled ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-igw"
  })
}