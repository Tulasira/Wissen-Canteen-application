resource "aws_route_table" "this" {
  count = var.enabled ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = var.route_table_name
    Tier = var.tier
  })
}

resource "aws_route_table_association" "this" {
  count = var.enabled ? length(var.subnet_ids) : 0

  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.this[0].id
}