resource "aws_network_acl" "public" {
  count = var.enabled ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-public-nacl"
    Tier = "public"
  })
}

resource "aws_network_acl" "private_app" {
  count = var.enabled ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-private-app-nacl"
    Tier = "private-app"
  })
}

resource "aws_network_acl" "db" {
  count = var.enabled ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-db-nacl"
    Tier = "database"
  })
}

resource "aws_network_acl_association" "public" {
  count = var.enabled ? length(var.public_subnet_ids) : 0

  subnet_id      = var.public_subnet_ids[count.index]
  network_acl_id = aws_network_acl.public[0].id
}

resource "aws_network_acl_association" "private_app" {
  count = var.enabled ? length(var.private_app_subnet_ids) : 0

  subnet_id      = var.private_app_subnet_ids[count.index]
  network_acl_id = aws_network_acl.private_app[0].id
}

resource "aws_network_acl_association" "db" {
  count = var.enabled ? length(var.db_subnet_ids) : 0

  subnet_id      = var.db_subnet_ids[count.index]
  network_acl_id = aws_network_acl.db[0].id
}