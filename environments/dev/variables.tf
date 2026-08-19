variable "aws_region" { type = string }
variable "project_name" { type = string }
variable "environment" { type = string }
variable "owner" { type = string }
variable "team" { type = string }
variable "managed_by" { type = string }

variable "vpc_enabled" { type = bool }
variable "alb_enabled" { type = bool }
variable "rds_enabled" { type = bool }
variable "s3_enabled" { type = bool }

variable "vpc_cidr" { type = string }

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for private application subnets"
  type        = list(string)
}

variable "db_subnet_cidrs" {
  type = list(string)
}

variable "enable_nacl" {
  type = bool
}

variable "public_nacl_ingress_rules" {
  type = list(object({
    rule_number = number
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "public_nacl_egress_rules" {
  type = list(object({
    rule_number = number
    cidr_block  = string
    from_port   = number
    to_port     = number
    protocol    = optional(string, "-1")
  }))
}

variable "allowed_http_cidr" {
  type = string
}

variable "allowed_egress_cidr" {
  type = string
}

##################################################
# ALB
##################################################

variable "alb_internal" {
  description = "Determines whether the ALB is internal or internet-facing."
  type        = bool
  default     = false
}

variable "alb_enable_deletion_protection" {
  type = bool
}

variable "alb_subnet_count" {
  description = "Number of subnets/AZs to use for ALB deployment"
  type        = number
  default     = 2
}

##################################################
# Target Group
##################################################

variable "target_group_port" {
  type = number
}

variable "target_group_protocol" {
  description = "Protocol used by the Target Group"
  type        = string
}

variable "target_type" {
  type = string
}

variable "health_check_enabled" {
  description = "Enable or disable health checks"
  type        = bool
}

variable "health_check_path" {
  type = string
}

variable "health_check_protocol" {
  description = "Protocol used by health checks"
  type        = string
}

variable "health_check_matcher" {
  description = "Expected HTTP response code"
  type        = string
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
}

variable "healthy_threshold" {
  description = "Healthy threshold"
  type        = number
}

variable "unhealthy_threshold" {
  description = "Unhealthy threshold"
  type        = number
}

##################################################
# Listener
##################################################

variable "listeners" {
  description = "Configuration for one or more ALB listeners"

  type = map(object({
    port                = number
    protocol            = string
    default_action_type = string
    content_type        = string
    message_body        = string
    status_code         = string
  }))
}

variable "listener_rules" {
  description = "Map of ALB listener rules"

  type = map(object({
    listener_key  = string
    priority      = number
    path_patterns = list(string)
  }))
}

##################################################
# S3
##################################################

variable "s3_bucket_name" {
  type = string
}

variable "s3_versioning_enabled" {
  type    = bool
  default = true
}

##################################################
# Secrets Manager
##################################################

variable "secret_name" {
  type = string
}

variable "secret_description" {
  type = string
}

##################################################
# Password Generation
##################################################

variable "db_username" {
  type      = string
  sensitive = true
}

variable "password_length" {
  type = number
}

variable "override_special" {
  type = string
}

variable "min_lower" {
  type = number
}

variable "min_upper" {
  type = number
}

variable "min_numeric" {
  type = number
}

variable "min_special" {
  type = number
}

variable "recovery_window_days" {
  type = number
}

##################################################
# RDS
##################################################

variable "db_name" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_engine_version" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_allocated_storage" {
  type = number
}

variable "db_storage_type" {
  description = "Storage type for RDS. Default is gp3 wherever applicable."
  type        = string
  default     = "gp3"
}

variable "db_port" {
  type = number
}

variable "db_multi_az" {
  type = bool
}

variable "parameter_group_family" {
  type = string
}

variable "db_parameters" {
  description = "Custom DB parameter overrides."

  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))
}

variable "option_group_engine_name" {
  type = string
}

variable "major_engine_version" {
  type = string
}

variable "db_options" {
  description = "Custom DB option overrides."

  type = list(object({
    option_name = string

    option_settings = list(object({
      name  = string
      value = string
    }))
  }))
}

variable "iam_database_authentication_enabled" {
  type = bool
}

variable "performance_insights_enabled" {
  type = bool
}

variable "performance_insights_retention_period" {
  type = number
}

variable "monitoring_interval" {
  description = "Enhanced Monitoring interval in seconds. Default 0 uses standard monitoring."
  type        = number
  default     = 0
}

variable "db_deletion_protection" {
  type = bool
}

variable "db_skip_final_snapshot" {
  type = bool
}

variable "db_backup_retention_period" {
  type = number
}

variable "auto_minor_version_upgrade" {
  type = bool
}

variable "preferred_backup_window" {
  type = string
}

variable "preferred_maintenance_window" {
  type = string
}

##################################################
# VPC Flow Logs
##################################################

variable "enable_vpc_flow_logs" {
  type = bool
}

variable "vpc_flow_log_traffic_type" {
  type = string
}

variable "vpc_flow_log_retention_in_days" {
  type = number
}

##################################################
# Tags
##################################################

variable "created_by" {
  description = "Name of the person who created the resources"
  type        = string
}

variable "created_for" {
  description = "Project or organization for which the resources are created"
  type        = string
}

####################################
# ECS
####################################

variable "ecs_enabled" {
  type = bool
}

variable "ecs_log_retention_days" {
  type = number
}

variable "container_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "ecs_cpu" {
  type = number
}

variable "ecs_memory" {
  type = number
}

variable "desired_count" {
  type = number
}

variable "fargate_spot_percentage" {
  type    = number
  default = 0
}

variable "operating_system_family" {
  type = string
}

variable "cpu_architecture" {
  type = string
}

variable "environment_variables" {

  type = list(object({
    name  = string
    value = string
  }))
}

variable "readonly_root_filesystem" {
  type = bool
}

variable "linux_init_process_enabled" {
  type = bool
}

variable "ecs_cpu_alarm_threshold" {
  description = "CPU utilization threshold for ECS alarm"
  type        = number
}


variable "ecs_memory_alarm_threshold" {
  description = "Memory utilization threshold for ECS alarm"
  type        = number
}

####################################
# ECS Container Health Check
####################################

variable "ecs_health_check_enabled" {
  description = "Enable ECS container health check"
  type        = bool
}

variable "ecs_health_check_command" {
  description = "Container health check command"
  type        = list(string)
}

variable "ecs_health_check_interval" {
  description = "Health check interval"
  type        = number
}

variable "ecs_health_check_timeout" {
  description = "Health check timeout"
  type        = number
}

variable "ecs_health_check_retries" {
  description = "Health check retries"
  type        = number
}

variable "ecs_health_check_start_period" {
  description = "Health check start period"
  type        = number
}

#########################################
# ECS Service
#########################################

variable "deployment_minimum_healthy_percent" {
  type = number
}

variable "deployment_maximum_percent" {
  type = number
}

variable "platform_version" {
  type = string
}

variable "health_check_grace_period_seconds" {
  type = number
}

variable "enable_execute_command" {
  type = bool
}

variable "propagate_tags" {
  type = string
}

####################################
# ECR
####################################

variable "ecr_enabled" {
  description = "Enable or disable ECR repository creation"
  type        = bool
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
}

variable "ecr_image_tag_mutability" {
  description = "Image tag mutability (MUTABLE or IMMUTABLE)"
  type        = string
}

variable "ecr_scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
}
#################################################
# EC2
#################################################

variable "ec2_enabled" {
  description = "Enable EC2 module"
  type        = bool
  default     = true
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Associate Public IP"
  type        = bool
}

variable "disable_api_termination" {
  description = "Enable EC2 termination protection"
  type        = bool
  default     = false
}

#################################################
# AMI
#################################################

variable "os_type" {
  description = "Operating System (ubuntu/amazon-linux)"
  type        = string
}

variable "custom_ami_id" {
  description = "Custom AMI ID"
  type        = string
}

#################################################
# Spot Instance
#################################################

variable "create_spot_instance" {
  description = "Create Spot Instance"
  type        = bool
}

#################################################
# Key Pair
#################################################

variable "create_key_pair" {
  description = "Create new Key Pair"
  type        = bool
}

variable "key_name" {
  description = "Key Pair Name"
  type        = string
}

variable "save_private_key" {
  description = "Save private key locally"
  type        = bool
}

#################################################
# IAM
#################################################

variable "attach_ssm_policy" {
  type    = bool
  default = true
}

variable "attach_cloudwatch_policy" {
  type    = bool
  default = true
}

variable "attach_ecr_policy" {
  type    = bool
  default = true
}

variable "attach_s3_policy" {
  type    = bool
  default = false
}

variable "additional_policies" {
  type    = list(string)
  default = []
}

#################################################
# Launch Template
#################################################

variable "user_data" {
  description = "User Data Script"
  type        = string
}

variable "ebs_optimized" {
  description = "Enable EBS Optimization for EC2"
  type        = bool
  default     = false
}

variable "monitoring_enabled" {
  description = "Enable detailed CloudWatch monitoring"
  type        = bool
  default     = true
}

#################################################
# EBS
#################################################

variable "create_ebs" {
  description = "Create EBS Volume"
  type        = bool
}

variable "volume_size" {
  description = "EBS Volume Size"
  type        = number
}

variable "volume_type" {
  description = "EBS Volume Type"
  type        = string
}

variable "ebs_encrypted" {
  description = "Encrypt EBS Volume"
  type        = bool
}

variable "device_name" {
  description = "Linux Device Name"
  type        = string
}

variable "kms_key_id" {
  description = "Optional KMS Key ID for EBS encryption"
  type        = string
  default     = null
}
#################################################
# Elastic IP
#################################################

variable "allocate_eip" {
  description = "Allocate Elastic IP"
  type        = bool
}

#################################################
# Security Group Rules
#################################################

variable "ec2_ingress_rules" {

  description = "EC2 Ingress Rules"

  type = list(object({
    description     = string
    port            = number
    cidr_blocks     = list(string)
    security_groups = list(string)
  }))
}

variable "ec2_egress_rules" {

  description = "EC2 Egress Rules"

  type = list(object({
    description = string
    cidr_blocks = list(string)
  }))
}

#########################################
# ECS Auto Scaling
#########################################

variable "min_capacity" {
  type = number
}

variable "max_capacity" {
  type = number
}

variable "cpu_target_value" {
  type = number
}

variable "memory_target_value" {
  type = number
}

variable "scale_in_cooldown" {
  type = number
}

variable "scale_out_cooldown" {
  type = number
}

variable "domain_name" {
  description = "Root domain name for the application"
  type        = string
}


##################################################
# ACM
##################################################

variable "acm_domain_name" {
  description = "Primary domain name for the ACM certificate"
  type        = string
}

variable "acm_subject_alternative_names" {
  description = "Additional domain names for the ACM certificate"
  type        = list(string)
  default     = []
}

variable "route53_zone_id" {
  description = "Route 53 hosted zone ID used for ACM DNS validation"
  type        = string
}
