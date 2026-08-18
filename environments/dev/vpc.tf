module "vpc" {
  source = "../../modules/vpc/vpc"

  enabled      = var.vpc_enabled
  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr

  tags = local.common_tags
}

module "internet_gateway" {
  source = "../../modules/vpc/internet_gateway"

  enabled      = var.vpc_enabled
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id

  tags = local.common_tags
}

module "subnets" {
  source = "../../modules/vpc/subnets"

  enabled      = var.vpc_enabled
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id

  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  db_subnet_cidrs          = var.db_subnet_cidrs
  availability_zones       = var.availability_zones

  tags = local.common_tags
}

module "public_route_table" {
  source = "../../modules/vpc/route_table"

  enabled          = var.vpc_enabled
  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = module.vpc.vpc_id
  route_table_name = "${var.project_name}-${var.environment}-public-rt"
  tier             = "public"
  subnet_ids       = module.subnets.public_subnet_ids

  tags = local.common_tags
}

module "public_route" {
  source = "../../modules/vpc/route"

  enabled                = var.vpc_enabled
  route_table_id         = module.public_route_table.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  internet_gateway_id    = module.internet_gateway.internet_gateway_id
  nat_gateway_id         = null
}

# Private route table is ready for private app subnets.
# NAT route is not called in dev because NAT Gateway is a paid service.
module "private_app_route_table" {
  source = "../../modules/vpc/route_table"

  enabled          = var.vpc_enabled
  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = module.vpc.vpc_id
  route_table_name = "${var.project_name}-${var.environment}-private-app-rt"
  tier             = "private-app"
  subnet_ids       = module.subnets.private_app_subnet_ids

  tags = local.common_tags
}

module "nacl" {
  source = "../../modules/vpc/nacl"

  enabled      = var.vpc_enabled && var.enable_nacl
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id

  public_subnet_ids      = module.subnets.public_subnet_ids
  private_app_subnet_ids = module.subnets.private_app_subnet_ids
  db_subnet_ids          = module.subnets.db_subnet_ids

  tags = local.common_tags
}

module "nacl_rule" {
  source = "../../modules/vpc/nacl_rule"

  enabled = var.vpc_enabled && var.enable_nacl

  public_nacl_id      = module.nacl.public_nacl_id
  private_app_nacl_id = module.nacl.private_app_nacl_id
  db_nacl_id          = module.nacl.db_nacl_id

  public_nacl_ingress_rules = var.public_nacl_ingress_rules
  public_nacl_egress_rules  = var.public_nacl_egress_rules

  private_app_nacl_ingress_rules = local.private_app_nacl_ingress_rules
  private_app_nacl_egress_rules  = local.private_app_nacl_egress_rules

  db_nacl_ingress_rules = local.db_nacl_ingress_rules
  db_nacl_egress_rules  = local.db_nacl_egress_rules
}

module "vpc_flow_log" {
  source = "../../modules/vpc/vpc-flow-log"

  enabled           = var.enable_vpc_flow_logs
  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  traffic_type      = var.vpc_flow_log_traffic_type
  retention_in_days = var.vpc_flow_log_retention_in_days

  tags = local.common_tags
}