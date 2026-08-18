# terraform apply -var-file=environments/dev.tfvars
# Smaller, cheaper footprint for a dev/staging environment.

project_name = "wissen-canteen"
environment  = "dev"
aws_region   = "ap-south-1"

vpc_cidr             = "10.30.0.0/16"
availability_zones   = ["ap-south-1a", "ap-south-1b"]
public_subnet_cidrs  = ["10.30.0.0/24", "10.30.1.0/24"]
private_subnet_cidrs = ["10.30.10.0/24", "10.30.11.0/24"]
single_nat_gateway   = true

route53_zone_id = "Z0123456789ABCDEFGHIJ"
api_domain_name = "api-dev.canteen.example.com"
web_domain_name = "dev.canteen.example.com"

container_port     = 3000
health_check_path  = "/health"
ecs_task_cpu       = 256
ecs_task_memory    = 512
ecs_desired_count  = 1
enable_autoscaling = false

db_engine_version     = "16.4"
db_instance_class     = "db.t4g.micro"
db_allocated_storage  = 20
db_name               = "canteen"
db_username           = "canteen_admin"
enable_multi_az        = false
db_deletion_protection = false
db_skip_final_snapshot = true # OK to skip in dev; set false in prod

enable_elasticache = false

log_retention_days       = 7
alarm_notification_email = "" # skip email alarms in dev
