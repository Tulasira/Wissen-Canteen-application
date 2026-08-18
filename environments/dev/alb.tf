module "alb_security_group" {
  source = "../../modules/security-group/security-group"

  enabled                    = var.alb_enabled
  security_group_name        = "${var.project_name}-${var.environment}-alb-sg"
  security_group_description = "Security group for Application Load Balancer"
  vpc_id                     = module.vpc.vpc_id

  tags = local.common_tags
}

module "alb_security_group_rule" {
  source = "../../modules/security-group/security-group-rule"

  enabled           = var.alb_enabled
  security_group_id = module.alb_security_group.security_group_id

  ingress_rules = [
    {
      description     = var.alb_internal ? "Allow HTTP traffic from VPC" : "Allow HTTP traffic from Internet"
      port            = 80
      cidr_blocks     = [local.alb_allowed_cidr]
      security_groups = []
    }
  ]

  egress_rules = [
    {
      description = "Allow all outbound traffic"
      cidr_blocks = [var.allowed_egress_cidr]
    }
  ]
}

module "load_balancer" {
  source = "../../modules/alb/load_balancer"

  enabled      = var.alb_enabled
  project_name = var.project_name
  environment  = var.environment

  public_subnet_ids = slice(
    var.alb_internal ? module.subnets.private_app_subnet_ids : module.subnets.public_subnet_ids,
    0,
    var.alb_subnet_count
  )

  security_group_ids         = [module.alb_security_group.security_group_id]
  internal                   = var.alb_internal
  enable_deletion_protection = var.alb_enable_deletion_protection

  tags = local.common_tags
}

module "target_group" {
  source = "../../modules/alb/target_group"

  enabled      = var.alb_enabled
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id

  target_group_port     = var.target_group_port
  target_group_protocol = var.target_group_protocol
  target_type           = var.target_type

  health_check_enabled  = var.health_check_enabled
  health_check_path     = var.health_check_path
  health_check_protocol = var.health_check_protocol
  health_check_matcher  = var.health_check_matcher
  health_check_interval = var.health_check_interval
  health_check_timeout  = var.health_check_timeout

  healthy_threshold   = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold

  tags = local.common_tags
}

module "load_balancer_listener" {
  source = "../../modules/alb/load_balancer_listener"

  enabled           = var.alb_enabled
  load_balancer_arn = module.load_balancer.alb_arn
  listeners         = var.listeners
}

module "load_balancer_listener_rule" {
  source = "../../modules/alb/load_balancer_listener_rule"

  enabled          = var.alb_enabled
  listener_arns    = module.load_balancer_listener.listener_arns
  target_group_arn = module.target_group.target_group_arn

  listener_rules = var.listener_rules
}