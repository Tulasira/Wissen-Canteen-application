# ECR Module

## Overview

This module creates an Amazon Elastic Container Registry (ECR) repository for storing Docker container images.

Amazon ECR is a fully managed container image registry service that integrates seamlessly with Amazon ECS and AWS Fargate. It allows secure storage, versioning, and management of container images.

This repository will be used by the ECS Task Definition to pull Docker images during deployment.

---

## Architecture Flow

```text
Developer
    ↓
Docker Build
    ↓
Docker Push
    ↓
Amazon ECR Repository
    ↓
Amazon ECS Task Definition
    ↓
AWS Fargate Tasks
```

---

## Resources Created

### Amazon ECR Repository

Creates a private container image repository.

Features:

- Private image storage
- Mutable or immutable image tags
- Image scanning on push
- Environment-based naming
- Common tagging strategy

---

## Features

- Secure Docker image storage
- Integration with ECS Fargate
- Automatic vulnerability scanning
- Configurable tag mutability
- Environment-based resource naming
- Reusable Terraform module
- Common tagging support

---

## Inputs

| Name | Description |
|--------|-------------|
| enabled | Enable or disable ECR creation |
| project_name | Project name used for naming |
| environment | Environment name (dev, qa, prod) |
| image_tag_mutability | MUTABLE or IMMUTABLE |
| scan_on_push | Enable image scanning on push |
| tags | Common tags applied to resources |

---

## Outputs

| Name | Description |
|--------|-------------|
| repository_name | Name of the ECR repository |
| repository_url | Repository URL used for Docker push/pull |
| repository_arn | ARN of the ECR repository |

---

## Example Usage

```hcl
module "ecr" {
  source = "../../modules/ecr"

  enabled      = true
  project_name = var.project_name
  environment  = var.environment

  image_tag_mutability = "MUTABLE"
  scan_on_push         = true

  tags = local.common_tags
}
```

---

## Example Docker Commands

### Authenticate Docker with ECR

```bash
aws ecr get-login-password \
--region us-east-2 \
| docker login \
--username AWS \
--password-stdin <account-id>.dkr.ecr.us-east-2.amazonaws.com
```

---

### Build Docker Image

```bash
docker build -t nginx-app .
```

---

### Tag Docker Image

```bash
docker tag nginx-app:latest \
<repository-url>:latest
```

---

### Push Docker Image

```bash
docker push <repository-url>:latest
```

---

## ECS Integration

The ECR repository URL can be directly used inside the ECS Task Definition:

```hcl
container_image = module.ecr.repository_url
```

Example:

```text
395120012657.dkr.ecr.us-east-2.amazonaws.com/vpc-alb-rds-dev:latest
```

AWS Fargate automatically pulls images from ECR using the ECS Task Execution Role.

---

## Security Benefits

- Private image repositories
- IAM-based access control
- Vulnerability scanning on image push
- No external Docker registry dependency
- Secure integration with ECS and Fargate
- AWS-managed infrastructure

---

## Notes

- This module creates only the ECR repository.
- Docker images must be pushed separately after repository creation.
- ECS Task Definitions can directly consume the repository URL.
- Image scanning can be enabled or disabled through Terraform variables.
- Tag mutability can be configured as:
  - `MUTABLE`
  - `IMMUTABLE`
- This module is fully reusable across multiple environments.
```**````