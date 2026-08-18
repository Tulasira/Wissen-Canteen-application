locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = var.owner
    Team        = var.team
    ManagedBy   = var.managed_by

    CreatedBy  = var.created_by
    CreatedFor = var.created_for
  }

  alb_allowed_cidr = var.alb_internal ? var.vpc_cidr : var.allowed_http_cidr

  ########################################################
  # Private Application NACL Rules
  ########################################################

  private_app_nacl_ingress_rules = [
    {
      rule_number = 100
      cidr_block  = var.vpc_cidr
      from_port   = 80
      to_port     = 80
    },
    {
      rule_number = 110
      cidr_block  = var.vpc_cidr
      from_port   = 443
      to_port     = 443
    },
    {
      rule_number = 120
      cidr_block  = var.vpc_cidr
      from_port   = 1024
      to_port     = 65535
    }
  ]

  private_app_nacl_egress_rules = [
    {
      rule_number = 100
      cidr_block  = var.vpc_cidr
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }
  ]

  ########################################################
  # Database NACL Rules
  ########################################################

  db_nacl_ingress_rules = [
    {
      rule_number = 100
      cidr_block  = var.vpc_cidr
      from_port   = var.db_port
      to_port     = var.db_port
    },
    {
      rule_number = 110
      cidr_block  = var.vpc_cidr
      from_port   = 1024
      to_port     = 65535
    }
  ]

  db_nacl_egress_rules = [
    {
      rule_number = 100
      cidr_block  = var.vpc_cidr
      from_port   = 1024
      to_port     = 65535
    }
  ]
}