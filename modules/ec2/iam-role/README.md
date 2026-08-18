# IAM Role Module

## Overview

The IAM Role module creates an AWS Identity and Access Management (IAM) Role for Amazon EC2 instances.

The role grants temporary AWS credentials to the EC2 instance through an IAM Instance Profile, eliminating the need to store long-term access keys on the server.

This module follows AWS security best practices by granting only the required permissions through managed IAM policies.

---

# Features

- Creates an IAM Role for EC2
- EC2 Trust Relationship
- CloudWatch Agent Access
- Amazon ECR Read Access
- Optional Amazon S3 Access
- Reusable Terraform module
- Enterprise-ready design
- Least Privilege Principle
- Tagging Support

---

# Resources Created

This module creates the following AWS resources:

- aws_iam_role
- aws_iam_role_policy_attachment

Depending on the configuration, the following AWS managed policies can be attached:

- AmazonSSMManagedInstanceCore *(optional)*
- CloudWatchAgentServerPolicy *(optional)*
- AmazonEC2ContainerRegistryReadOnly *(optional)*
- AmazonS3ReadOnlyAccess *(optional)*

---

# Architecture

```text
                EC2 Instance
                      │
                      ▼
               IAM Instance Profile
                      │
                      ▼
                  IAM Role
                      │
      ┌───────────────┼────────────────┐
      │               │                │
      ▼               ▼                ▼
 CloudWatch      Amazon ECR      Amazon S3
    Policy        Read Policy    Read Policy
```

---

# Why IAM Roles?

Instead of storing AWS Access Keys inside an EC2 instance, AWS automatically provides temporary credentials through the IAM Role.

Benefits include:

- Improved security
- Automatic credential rotation
- No hardcoded secrets
- Eases compliance with AWS security best practices

---

# Input Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| enabled | Enable module | bool | Yes |
| project_name | Project name | string | Yes |
| environment | Environment name | string | Yes |
| attach_cloudwatch_policy | Attach CloudWatch Agent policy | bool | No |
| attach_ecr_policy | Attach Amazon ECR Read policy | bool | No |
| attach_s3_policy | Attach Amazon S3 Read policy | bool | No |
| tags | Resource tags | map(string) | Yes |

---

# Output Values

| Name | Description |
|------|-------------|
| role_name | IAM Role Name |
| role_arn | IAM Role ARN |

---

# Example Usage

```hcl
module "iam_role" {
  source = "../../modules/ec2/iam-role"

  enabled      = true
  project_name = var.project_name
  environment  = var.environment

  attach_cloudwatch_policy = true
  attach_ecr_policy        = true
  attach_s3_policy         = false

  tags = local.common_tags
}
```

---

# Deployment Flow

```text
Terraform Apply
        │
        ▼
Create IAM Role
        │
        ▼
Configure EC2 Trust Policy
        │
        ▼
Attach AWS Managed Policies
        │
        ▼
Return Role ARN
        │
        ▼
Attach to Instance Profile
```

---

# AWS Managed Policies

Depending on your configuration, the module can attach:

| Policy | Purpose |
|---------|----------|
| AmazonSSMManagedInstanceCore | Systems Manager access |
| CloudWatchAgentServerPolicy | CloudWatch metrics and logs |
| AmazonEC2ContainerRegistryReadOnly | Pull Docker images from Amazon ECR |
| AmazonS3ReadOnlyAccess | Read objects from Amazon S3 |

---

# Security Best Practices

- Never use IAM Users inside EC2.
- Always use IAM Roles.
- Follow the Principle of Least Privilege.
- Attach only the policies required by the application.
- Use managed policies whenever possible.
- Avoid AdministratorAccess on EC2 instances.

---

# Notes

- This module creates only the IAM Role.
- The IAM Role is attached to an EC2 instance through the Instance Profile module.
- Additional custom IAM policies can be attached separately if required.
- The role is intended to provide secure, temporary AWS credentials to the EC2 instance.

---

# Future Enhancements

- Custom IAM Policies
- Inline Policy Support
- Permission Boundaries
- IAM Role Permissions Analyzer
- Cross-Account Role Support
- KMS Permissions
- Secrets Manager Permissions
- CloudWatch Logs Full Access (Optional)

---

# Key Learning Outcomes

- AWS IAM Roles
- EC2 Trust Policies
- IAM Managed Policies
- Principle of Least Privilege
- Temporary AWS Credentials
- EC2 Security Best Practices
- Terraform IAM Resources
- Enterprise IAM Design