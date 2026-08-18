resource "aws_eip" "this" {
  count = var.enabled ? 1 : 0

  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-nat-eip"
  })
}

resource "aws_nat_gateway" "this" {
  count = var.enabled ? 1 : 0

  allocation_id = aws_eip.this[0].id
  subnet_id     = var.public_subnet_id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-nat-gateway"
  })

  depends_on = [var.internet_gateway_id]
}