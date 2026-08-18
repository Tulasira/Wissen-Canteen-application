######################################################
# Security Group
######################################################

module "ec2_security_group" {
  source = "../../modules/security-group/security-group"

  enabled                    = var.ec2_enabled
  security_group_name        = "${var.project_name}-${var.environment}-ec2-sg"
  security_group_description = "Security Group for EC2"
  vpc_id                     = module.vpc.vpc_id

  tags = local.common_tags
}

module "ec2_security_group_rule" {
  source = "../../modules/security-group/security-group-rule"

  enabled           = var.ec2_enabled
  security_group_id = module.ec2_security_group.security_group_id

  ingress_rules = var.ec2_ingress_rules
  egress_rules  = var.ec2_egress_rules
}

######################################################
# AMI
######################################################

module "ami" {
  source = "../../modules/ec2/ami"

  os_type       = var.os_type
  custom_ami_id = var.custom_ami_id
}

######################################################
# Key Pair
######################################################

module "key_pair" {
  source = "../../modules/ec2/key-pair"

  enabled          = var.ec2_enabled
  create_key_pair  = var.create_key_pair
  key_name         = var.key_name
  save_private_key = var.save_private_key

  tags = local.common_tags
}

######################################################
# IAM Role
######################################################

module "iam_role" {
  source = "../../modules/ec2/iam-role"

  enabled      = var.ec2_enabled
  project_name = var.project_name
  environment  = var.environment

  attach_ssm_policy        = var.attach_ssm_policy
  attach_cloudwatch_policy = var.attach_cloudwatch_policy
  attach_ecr_policy        = var.attach_ecr_policy
  attach_s3_policy         = var.attach_s3_policy

  additional_policies = var.additional_policies

  tags = local.common_tags
}

######################################################
# Instance Profile
######################################################

module "instance_profile" {
  source = "../../modules/ec2/instance-profile"

  enabled = var.ec2_enabled

  project_name = var.project_name
  environment  = var.environment

  role_name = module.iam_role.role_name

  tags = local.common_tags
}

######################################################
# Launch Template
######################################################

module "launch_template" {
  source = "../../modules/ec2/launch-template"

  enabled = var.ec2_enabled

  project_name = var.project_name
  environment  = var.environment

  ami_id        = module.ami.ami_id
  instance_type = var.instance_type
  key_name      = module.key_pair.key_name

  security_group_ids = [
    module.ec2_security_group.security_group_id
  ]

  iam_instance_profile = module.instance_profile.instance_profile_name

  user_data = var.user_data

  ebs_optimized      = var.ebs_optimized
  monitoring_enabled = var.monitoring_enabled

  volume_size = var.volume_size
  volume_type = var.volume_type

  delete_on_termination = true
  encrypted             = var.ebs_encrypted

  spot_instance = var.create_spot_instance

  tags = local.common_tags
}

######################################################
# EC2 Instance
######################################################

module "instance" {
  source = "../../modules/ec2/instance"

  enabled = var.ec2_enabled

  project_name = var.project_name
  environment  = var.environment

  launch_template_id = module.launch_template.launch_template_id

  launch_template_version = module.launch_template.launch_template_latest_version

  subnet_id = module.subnets.public_subnet_ids[0]

  associate_public_ip_address = var.associate_public_ip_address

  disable_api_termination = var.disable_api_termination

  tags = local.common_tags
}
######################################################
# EBS Volume
######################################################

module "ebs" {
  source = "../../modules/ec2/ebs"

  enabled = var.ec2_enabled && var.create_ebs

  project_name = var.project_name
  environment  = var.environment

  availability_zone = module.instance.availability_zone

  volume_size = var.volume_size
  volume_type = var.volume_type

  encrypted  = var.ebs_encrypted
  kms_key_id = var.kms_key_id

  tags = local.common_tags
}
######################################################
# Volume Attachment
######################################################

module "volume_attachment" {
  source = "../../modules/ec2/volume-attachment"

  enabled = var.ec2_enabled && var.create_ebs

  instance_id = module.instance.instance_id

  volume_id = module.ebs.volume_id

  device_name = var.device_name
}

######################################################
# Elastic IP
######################################################

module "elastic_ip" {
  source = "../../modules/ec2/elastic-ip"

  enabled = var.ec2_enabled && var.allocate_eip

  project_name = var.project_name
  environment  = var.environment

  instance_id = module.instance.instance_id

  tags = local.common_tags
}