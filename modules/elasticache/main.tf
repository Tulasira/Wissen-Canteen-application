# Only needed if ecs_desired_count > 1, so multiple API tasks can share the
# QR-scan rate limiter state instead of each holding it in memory. The root
# module only instantiates this module when enable_elasticache = true.

resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.name_prefix}-cache-subnets"
  subnet_ids = var.private_subnet_ids
}

resource "aws_elasticache_cluster" "this" {
  cluster_id         = "${var.name_prefix}-cache"
  engine             = "redis"
  engine_version     = var.engine_version
  node_type          = var.node_type
  num_cache_nodes    = 1
  port               = 6379
  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = [var.security_group_id]

  tags = merge(var.tags, { Name = "${var.name_prefix}-cache" })
}

resource "aws_secretsmanager_secret" "redis_url" {
  name                    = "${var.name_prefix}/redis_url"
  recovery_window_in_days = var.recovery_window_days
  tags                    = merge(var.tags, { Name = "${var.name_prefix}-redis_url" })
}

resource "aws_secretsmanager_secret_version" "redis_url" {
  secret_id     = aws_secretsmanager_secret.redis_url.id
  secret_string = "redis://${aws_elasticache_cluster.this.cache_nodes[0].address}:6379"
}
