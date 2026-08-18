# Wissen Canteen — AWS Terraform (modular)

Same infrastructure as the flat version — ECS/Fargate API behind an ALB,
RDS PostgreSQL, S3+CloudFront web portal — restructured into reusable
modules with per-environment tfvars, so `dev` and `prod` (or more) can share
the same module code with different sizing.

## Structure

```
versions.tf                  Root providers (incl. us-east-1 alias for CloudFront ACM)
variables.tf                  Root input variables
locals.tf                     Naming, tags, the DATABASE_URL assembled from module.rds outputs
main.tf                       Wires every module together
outputs.tf                    Root outputs
terraform.tfvars.example      Copy to terraform.tfvars for ad-hoc use
environments/
  dev.tfvars                  Smaller/cheaper sizing, alarms off
  prod.tfvars                 Production sizing, deletion_protection on
modules/
  networking/                 VPC, subnets, NAT, route tables, security groups
  dns_acm/                    ACM certs (API regional + web us-east-1) + Route 53 validation
  alb/                        ALB, target group, HTTP->HTTPS redirect, HTTPS listener
  ecr/                        API image repository + lifecycle policy
  rds/                        PostgreSQL instance, subnet group, generated password
  secrets/                    Secrets Manager entries (generated + DATABASE_URL + Azure AD)
  iam/                        ECS execution role (pull/log/read-secrets) + task role
  ecs/                        Cluster, log group, task definition, service, autoscaling
  s3_cloudfront/               Private S3 bucket + CloudFront (OAC, SPA fallback routing)
  elasticache/                 Optional phase-2 Redis (only instantiated if enabled)
  monitoring/                  SNS topic + CloudWatch alarms (ALB 5xx, ECS/RDS CPU, RDS storage)
```

Root-level `aws_route53_record` resources (API -> ALB alias, web -> CloudFront
alias) stay in `main.tf` rather than their own module — they're two records
gluing two module outputs together, not worth the indirection.

## Before you run this

Same two blockers as always, they live in the app repo, not this codebase:

1. **A `Dockerfile`** in `apps/api` — needed to build the image pushed to ECR.
2. **A `/health` endpoint** in the NestJS API — the ALB target group health
   check depends on it (`var.health_check_path`, default `/health`).

You'll also need an existing Route 53 hosted zone, and the Azure AD
(Microsoft Entra ID) `client_id` / mail `client_secret` values.

## Usage

```bash
terraform init

# ad-hoc, using terraform.tfvars
cp terraform.tfvars.example terraform.tfvars
terraform plan  -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars

# or per environment
terraform plan  -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars

terraform plan  -var-file=environments/prod.tfvars
terraform apply -var-file=environments/prod.tfvars
```

Pass Azure AD secrets via environment variables rather than committing them:

```bash
export TF_VAR_azure_ad_client_id="..."
export TF_VAR_azure_mail_client_secret="..."
```

### Running dev and prod from the same codebase safely

Each environment needs its **own state** so a `dev` apply can never touch
`prod` resources. With the S3 backend uncommented in `versions.tf`, use a
different state key per environment:

```bash
terraform init -backend-config="key=canteen/dev/terraform.tfstate"
terraform apply -var-file=environments/dev.tfvars

# ...separately, for prod...
terraform init -reconfigure -backend-config="key=canteen/prod/terraform.tfstate"
terraform apply -var-file=environments/prod.tfvars
```

Or use [Terraform workspaces](https://developer.hashicorp.com/terraform/language/state/workspaces)
if you prefer that model — either works with this structure unchanged.

### First deploy vs. subsequent deploys

The task definition ships with a placeholder image tag (`bootstrap`) so the
first `apply` succeeds before any image exists in ECR. The ECS service
ignores further task-definition drift (`lifecycle.ignore_changes` in
`modules/ecs`) — day-to-day image deploys should go through CI:

```bash
aws ecs register-task-definition --cli-input-json file://task-def.json
aws ecs update-service --cluster <cluster> --service <service> --force-new-deployment
```

Web portal deploys:

```bash
npm run build
aws s3 sync dist/ s3://$(terraform output -raw web_s3_bucket_name)/ --delete
aws cloudfront create-invalidation \
  --distribution-id $(terraform output -raw cloudfront_distribution_id) \
  --paths "/*"
```

## Remote state

Local state is fine to try this out, not for a team. Uncomment and configure
the `backend "s3"` block in `versions.tf`, and create the bucket/DynamoDB
lock table beforehand — a backend can't configure itself.

## Phase 2 toggles

Every phase-2 item from the source AWS Components doc is a real, working
module — just off by default:

- `enable_multi_az = true` — RDS Multi-AZ failover (`modules/rds`)
- `enable_autoscaling = true` — ECS service scales 1→N on CPU (`modules/ecs`)
- `enable_elasticache = true` — provisions Redis (`modules/elasticache`,
  only instantiated when this is true); required if `ecs_desired_count > 1`
  so the QR-scan rate limiter is shared instead of per-task in-memory
- `single_nat_gateway = false` — one NAT Gateway per AZ instead of one shared

## Adding a third environment (e.g. staging)

Copy `environments/dev.tfvars` to `environments/staging.tfvars`, adjust
`environment`, sizing, and domain names, then `terraform apply
-var-file=environments/staging.tfvars` with its own state key. No module
changes needed — that's the point of the modular structure.
