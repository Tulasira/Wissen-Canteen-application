############################################
# 1. Networking — VPC, subnets, NAT, security groups
############################################

module "networking" {
  source = "./modules/networking"

  name_prefix           = local.name_prefix
  vpc_cidr               = var.vpc_cidr
  availability_zones     = var.availability_zones
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  single_nat_gateway     = var.single_nat_gateway
  container_port         = var.container_port
  enable_elasticache_sg  = var.enable_elasticache
  tags                   = local.common_tags
}

############################################
# 2. DNS / ACM — certificates + validation records
############################################

module "dns_acm" {
  source = "./modules/dns_acm"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  name_prefix     = local.name_prefix
  route53_zone_id = var.route53_zone_id
  api_domain_name = var.api_domain_name
  web_domain_name = var.web_domain_name
  tags            = local.common_tags
}

############################################
# 3. ALB — fronts the ECS service
############################################

module "alb" {
  source = "./modules/alb"

  name_prefix            = local.name_prefix
  vpc_id                 = module.networking.vpc_id
  public_subnet_ids      = module.networking.public_subnet_ids
  alb_security_group_id  = module.networking.alb_security_group_id
  container_port         = var.container_port
  health_check_path      = var.health_check_path
  certificate_arn        = module.dns_acm.api_certificate_arn
  tags                   = local.common_tags
}

############################################
# 4. ECR — API image repository
############################################

module "ecr" {
  source = "./modules/ecr"

  name_prefix = local.name_prefix
  tags        = local.common_tags
}

############################################
# 5. RDS — PostgreSQL database
############################################

module "rds" {
  source = "./modules/rds"

  name_prefix              = local.name_prefix
  private_subnet_ids       = module.networking.private_subnet_ids
  rds_security_group_id    = module.networking.rds_security_group_id
  engine_version            = var.db_engine_version
  instance_class            = var.db_instance_class
  allocated_storage         = var.db_allocated_storage
  max_allocated_storage     = var.db_max_allocated_storage
  db_name                   = var.db_name
  db_username               = var.db_username
  backup_retention_days     = var.db_backup_retention_days
  multi_az                  = var.enable_multi_az
  deletion_protection       = var.db_deletion_protection
  skip_final_snapshot        = var.db_skip_final_snapshot
  tags                       = local.common_tags
}

############################################
# 6. Secrets Manager
############################################

module "secrets" {
  source = "./modules/secrets"

  name_prefix               = local.name_prefix
  generated_secret_names    = local.generated_secret_names
  database_url               = local.database_url
  azure_ad_client_id         = var.azure_ad_client_id
  azure_mail_client_secret   = var.azure_mail_client_secret
  tags                       = local.common_tags
}

############################################
# 7. IAM — ECS execution/task roles
############################################

module "iam" {
  source = "./modules/iam"

  name_prefix = local.name_prefix
  secret_arns = module.secrets.secret_arns
  tags        = local.common_tags
}

############################################
# 8. ECS — cluster, task definition, service
############################################

module "ecs" {
  source = "./modules/ecs"

  name_prefix              = local.name_prefix
  environment               = var.environment
  aws_region                 = var.aws_region
  private_subnet_ids         = module.networking.private_subnet_ids
  ecs_security_group_id      = module.networking.ecs_security_group_id
  execution_role_arn         = module.iam.execution_role_arn
  task_role_arn               = module.iam.task_role_arn
  ecr_repository_url          = module.ecr.repository_url
  container_image_tag         = var.container_image_tag
  container_port               = var.container_port
  task_cpu                     = var.ecs_task_cpu
  task_memory                   = var.ecs_task_memory
  desired_count                 = var.ecs_desired_count
  target_group_arn              = module.alb.target_group_arn
  https_listener_arn             = module.alb.https_listener_arn
  secret_arns                    = module.secrets.secret_arns
  log_retention_days             = var.log_retention_days
  enable_autoscaling             = var.enable_autoscaling
  autoscaling_min_capacity       = var.autoscaling_min_capacity
  autoscaling_max_capacity       = var.autoscaling_max_capacity
  autoscaling_cpu_target         = var.autoscaling_cpu_target
  tags                           = local.common_tags
}

############################################
# 9. S3 + CloudFront — admin web portal
############################################

module "s3_cloudfront" {
  source = "./modules/s3_cloudfront"

  name_prefix           = local.name_prefix
  account_id             = data.aws_caller_identity.current.account_id
  web_domain_name        = var.web_domain_name
  web_certificate_arn    = module.dns_acm.web_certificate_arn
  tags                   = local.common_tags
}

############################################
# 10. Phase 2 (optional) — ElastiCache Redis
############################################

module "elasticache" {
  source = "./modules/elasticache"
  count  = var.enable_elasticache ? 1 : 0

  name_prefix           = local.name_prefix
  private_subnet_ids    = module.networking.private_subnet_ids
  security_group_id     = module.networking.elasticache_security_group_id
  node_type              = var.elasticache_node_type
  tags                   = local.common_tags
}

############################################
# 11. Monitoring — alarms + SNS
############################################

module "monitoring" {
  source = "./modules/monitoring"

  name_prefix                = local.name_prefix
  alarm_notification_email   = var.alarm_notification_email
  alb_arn_suffix               = module.alb.alb_arn_suffix
  ecs_cluster_name             = module.ecs.cluster_name
  ecs_service_name             = module.ecs.service_name
  rds_instance_id               = module.rds.db_instance_id
  tags                          = local.common_tags
}

############################################
# 12. Route 53 alias records — API -> ALB, web -> CloudFront
############################################

resource "aws_route53_record" "api" {
  zone_id = var.route53_zone_id
  name    = var.api_domain_name
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "web" {
  zone_id = var.route53_zone_id
  name    = var.web_domain_name
  type    = "A"

  alias {
    name                   = module.s3_cloudfront.distribution_domain_name
    zone_id                = module.s3_cloudfront.distribution_hosted_zone_id
    evaluate_target_health = false
  }
}
