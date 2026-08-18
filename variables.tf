############################################
# General
############################################

variable "project_name" {
  type    = string
  default = "wissen-canteen"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "tags" {
  type    = map(string)
  default = {}
}

############################################
# Networking
############################################

variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.20.0.0/24", "10.20.1.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.20.10.0/24", "10.20.11.0/24"]
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

############################################
# DNS / TLS
############################################

variable "route53_zone_id" {
  description = "Hosted zone ID for the domain(s) this app will use. The zone must already exist."
  type        = string
}

variable "api_domain_name" {
  type = string
}

variable "web_domain_name" {
  type = string
}

############################################
# Compute — ECS / Fargate
############################################

variable "container_port" {
  type    = number
  default = 3000
}

variable "health_check_path" {
  type    = string
  default = "/health"
}

variable "ecs_task_cpu" {
  type    = number
  default = 512
}

variable "ecs_task_memory" {
  type    = number
  default = 1024
}

variable "ecs_desired_count" {
  description = "Keep at 1 unless enable_elasticache is also true — the QR-scan rate limiter is in-memory otherwise."
  type        = number
  default     = 1
}

variable "container_image_tag" {
  description = "Overridden by CI on each deploy; 'bootstrap' lets the first apply succeed before any image has been pushed."
  type        = string
  default     = "bootstrap"
}

variable "enable_autoscaling" {
  type    = bool
  default = false
}

variable "autoscaling_min_capacity" {
  type    = number
  default = 1
}

variable "autoscaling_max_capacity" {
  type    = number
  default = 4
}

variable "autoscaling_cpu_target" {
  type    = number
  default = 60
}

############################################
# Database — RDS PostgreSQL
############################################

variable "db_engine_version" {
  type    = string
  default = "16.4"
}

variable "db_instance_class" {
  type    = string
  default = "db.t4g.micro"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}

variable "db_max_allocated_storage" {
  type    = number
  default = 100
}

variable "db_name" {
  type    = string
  default = "canteen"
}

variable "db_username" {
  type    = string
  default = "canteen_admin"
}

variable "db_backup_retention_days" {
  type    = number
  default = 7
}

variable "enable_multi_az" {
  type    = bool
  default = false
}

variable "db_deletion_protection" {
  type    = bool
  default = false
}

variable "db_skip_final_snapshot" {
  type    = bool
  default = true
}

############################################
# Phase 2 — ElastiCache
############################################

variable "enable_elasticache" {
  description = "Only required if ecs_desired_count > 1, for the shared QR-scan rate limiter."
  type        = bool
  default     = false
}

variable "elasticache_node_type" {
  type    = string
  default = "cache.t4g.micro"
}

############################################
# Secrets — values that must come from outside Terraform
############################################

variable "azure_ad_client_id" {
  description = "Microsoft Entra ID (Azure AD) application client ID used for SSO."
  type        = string
  sensitive   = true
  default     = ""
}

variable "azure_mail_client_secret" {
  description = "Client secret for the Azure AD app registration used to send mail via Microsoft Graph."
  type        = string
  sensitive   = true
  default     = ""
}

############################################
# Observability
############################################

variable "log_retention_days" {
  type    = number
  default = 30
}

variable "alarm_notification_email" {
  type    = string
  default = ""
}
