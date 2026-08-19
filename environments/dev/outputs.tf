output "vpc_id" {
  value = module.vpc.vpc_id
}

######################################################
# ACM
######################################################

output "acm_certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = module.acm.certificate_arn
}

output "acm_certificate_domain_name" {
  description = "Primary domain name of the ACM certificate"
  value       = module.acm.certificate_domain_name
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.subnets.private_app_subnet_ids
}

output "db_subnet_ids" {
  value = module.subnets.db_subnet_ids
}

output "public_route_table_id" {
  value = module.public_route_table.route_table_id
}

output "private_app_route_table_id" {
  value = module.private_app_route_table.route_table_id
}

output "public_nacl_id" {
  value = module.nacl.public_nacl_id
}

output "private_app_nacl_id" {
  value = module.nacl.private_app_nacl_id
}

output "db_nacl_id" {
  value = module.nacl.db_nacl_id
}

output "alb_dns_name" {
  value = module.load_balancer.alb_dns_name
}

output "alb_security_group_id" {
  value = module.alb_security_group.security_group_id
}

output "rds_security_group_id" {
  value = module.rds_security_group.security_group_id
}

output "secret_arn" {
  value     = module.secrets_manager.secret_arn
  sensitive = true
}

output "rds_identifier" {
  value = module.db_instance.rds_identifier
}

output "rds_endpoint" {
  value     = module.db_instance.rds_endpoint
  sensitive = true
}

output "rds_parameter_group_name" {
  value = module.db_parameter_group.parameter_group_name
}

output "rds_option_group_name" {
  value = module.db_option_group.option_group_name
}

output "rds_arn" {
  value = module.db_instance.rds_arn
}

output "vpc_flow_log_id" {
  value = module.vpc_flow_log.flow_log_id
}

output "vpc_flow_log_group_name" {
  value = module.vpc_flow_log.flow_log_group_name
}

output "vpc_flow_log_role_arn" {
  value = module.vpc_flow_log.flow_log_role_arn
}

output "rds_monitoring_role_arn" {
  value = module.db_monitoring.monitoring_role_arn
}

output "listener_rule_arns" {
  value = module.load_balancer_listener_rule.listener_rule_arns
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}

output "s3_bucket_id" {
  value = module.s3.bucket_id
}

output "ecs_cluster_id" {
  value = module.ecs_cluster.cluster_id
}

output "ecs_cluster_name" {
  value = module.ecs_cluster.cluster_name
}

output "ecs_task_definition_arn" {
  value = module.ecs_task_definition.task_definition_arn
}

output "ecs_service_name" {
  value = module.ecs_service.service_name
}

output "ecs_service_arn" {
  value = module.ecs_service.service_arn
}

####################################
# ECR
####################################

output "ecr_repository_name" {
  value = module.ecr.repository_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "ecr_repository_arn" {
  value = module.ecr.repository_arn
}

######################################################
# EC2
######################################################

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = module.instance.instance_id
}

output "ec2_instance_arn" {
  description = "EC2 Instance ARN"
  value       = module.instance.instance_arn
}

output "ec2_public_ip" {
  description = "EC2 Public IP"
  value       = module.instance.instance_public_ip
}

output "ec2_private_ip" {
  description = "EC2 Private IP"
  value       = module.instance.instance_private_ip
}

output "ec2_state" {
  description = "EC2 Instance State"
  value       = module.instance.instance_state
}

output "ec2_availability_zone" {
  description = "Availability Zone"
  value       = module.instance.availability_zone
}

######################################################
# AMI
######################################################

output "ec2_ami_id" {
  description = "AMI used by EC2"
  value       = module.ami.ami_id
}

######################################################
# Key Pair
######################################################

output "ec2_key_name" {
  description = "Key Pair Name"
  value       = module.key_pair.key_name
}

output "private_key_path" {
  description = "Private Key Path"
  value       = module.key_pair.private_key_path
}

######################################################
# IAM
######################################################

output "ec2_role_name" {
  description = "IAM Role Name"
  value       = module.iam_role.role_name
}

output "ec2_role_arn" {
  description = "IAM Role ARN"
  value       = module.iam_role.role_arn
}

output "instance_profile_name" {
  description = "Instance Profile Name"
  value       = module.instance_profile.instance_profile_name
}

output "instance_profile_arn" {
  description = "Instance Profile ARN"
  value       = module.instance_profile.instance_profile_arn
}

######################################################
# Launch Template
######################################################

output "launch_template_id" {
  description = "Launch Template ID"
  value       = module.launch_template.launch_template_id
}

output "launch_template_name" {
  description = "Launch Template Name"
  value       = module.launch_template.launch_template_name
}

output "launch_template_latest_version" {
  description = "Latest Launch Template Version"
  value       = module.launch_template.launch_template_latest_version
}

######################################################
# EBS
######################################################

output "ebs_volume_id" {
  description = "EBS Volume ID"
  value       = module.ebs.volume_id
}

output "ebs_volume_arn" {
  description = "EBS Volume ARN"
  value       = module.ebs.volume_arn
}

######################################################
# Volume Attachment
######################################################

output "volume_attachment_id" {
  description = "Volume Attachment ID"
  value       = module.volume_attachment.attachment_id
}

######################################################
# Elastic IP
######################################################

output "elastic_ip" {
  description = "Elastic Public IP"
  value       = module.elastic_ip.public_ip
}

output "elastic_ip_dns" {
  description = "Elastic Public DNS"
  value       = module.elastic_ip.public_dns
}

output "elastic_ip_allocation_id" {
  description = "Elastic IP Allocation ID"
  value       = module.elastic_ip.allocation_id
}

####################################
# ECS Auto Scaling
####################################

output "ecs_autoscaling_resource_id" {
  description = "ECS Auto Scaling Resource ID"
  value       = module.ecs_auto_scaling.resource_id
}

output "ecs_cpu_scaling_policy_arn" {
  description = "CPU Auto Scaling Policy ARN"
  value       = module.ecs_auto_scaling.cpu_scaling_policy_arn
}

output "ecs_memory_scaling_policy_arn" {
  description = "Memory Auto Scaling Policy ARN"
  value       = module.ecs_auto_scaling.memory_scaling_policy_arn
}
