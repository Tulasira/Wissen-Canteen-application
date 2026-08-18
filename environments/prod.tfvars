# terraform apply -var-file=environments/prod.tfvars
# Production sizing. Multi-AZ/autoscaling default off here too — flip once
# real usage data justifies the cost, per the phase-1/phase-2 split.

project_name = "wissen-canteen"
environment  = "prod"
aws_region   = "ap-south-1"

vpc_cidr             = "10.20.0.0/16"
availability_zones   = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidrs  = ["10.20.0.0/24", "10.20.1.0/24"]
private_subnet_cidrs = ["10.20.10.0/24", "10.20.11.0/24"]
single_nat_gateway   = true # set false for per-AZ NAT resilience once traffic justifies it

route53_zone_id = "Z0123456789ABCDEFGHIJ"
api_domain_name = "api.canteen.example.com"
web_domain_name = "canteen.example.com"

container_port     = 3000
health_check_path  = "/health"
ecs_task_cpu       = 512
ecs_task_memory    = 1024
ecs_desired_count  = 1
enable_autoscaling = false

db_engine_version     = "16.4"
db_instance_class     = "db.t4g.micro" # revisit after observing real load
db_allocated_storage  = 20
db_name               = "canteen"
db_username           = "canteen_admin"
enable_multi_az         = false # flip once uptime SLA requires it
db_deletion_protection  = true  # protect the prod database from accidental destroy
db_skip_final_snapshot  = false # take a final snapshot on any prod destroy

enable_elasticache = false # only needed once ecs_desired_count > 1

log_retention_days       = 30
alarm_notification_email = "devops@example.com"
