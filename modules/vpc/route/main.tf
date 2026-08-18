resource "aws_route" "this" {
  count = var.enabled ? 1 : 0

  route_table_id         = var.route_table_id
  destination_cidr_block = var.destination_cidr_block

  gateway_id     = var.internet_gateway_id
  nat_gateway_id = var.nat_gateway_id
}