# IAM Instance Profile Module

## Overview

The IAM Instance Profile module creates an AWS IAM Instance Profile and associates it with an existing IAM Role.

Amazon EC2 instances cannot directly assume an IAM Role. Instead, AWS requires an IAM Instance Profile to act as a container for the IAM Role. This module bridges the IAM Role and the EC2 instance, allowing secure access to AWS services without storing long-term credentials.

---

# Features

- Creates an IAM Instance Profile
- Associates an IAM Role with the Instance Profile
- Enables temporary AWS credentials for EC2
- Enterprise-ready reusable module
- Supports any EC2 workload
- Tagging support

---

# Resources Created

This module creates the following AWS resource:

- aws_iam_instance_profile

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
        Temporary AWS Credentials
                   │
     ┌─────────────┼─────────────┐
     ▼             ▼             ▼
 Amazon S3     Amazon ECR   CloudWatch
```

---

# Why Instance Profiles?

AWS EC2 instances cannot directly attach an IAM Role.

The Instance Profile acts as an intermediary between:

- EC2 Instance
- IAM Role

Once attached, AWS automatically provides temporary credentials to the EC2 instance through the Instance Metadata Service (IMDS).

This eliminates the need to store AWS Access Keys on the server.

---

# Input Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| enabled | Enable module | bool | Yes |
| project_name | Project name | string | Yes |
| environment | Environment name | string | Yes |
| role_name | IAM Role Name | string | Yes |
| tags | Resource tags | map(string) | Yes |

---

# Output Values

| Name | Description |
|------|-------------|
| instance_profile_name | IAM Instance Profile Name |
| instance_profile_arn | IAM Instance Profile ARN |
| instance_profile_id | IAM Instance Profile ID |

---

# Example Usage

```hcl
module "instance_profile" {
  source = "../../modules/ec2/instance-profile"

  enabled      = true
  project_name = var.project_name
  environment  = var.environment

  role_name = module.iam_role.role_name

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
Create Instance Profile
        │
        ▼
Associate IAM Role
        │
        ▼
Attach Instance Profile
to Launch Template
        │
        ▼
Launch EC2 Instance
```

---

# Benefits

- No AWS Access Keys on EC2
- Automatic Credential Rotation
- Secure AWS API Access
- Easy IAM Policy Management
- AWS Best Practice
- Enterprise Ready

---

# Security Best Practices

- Always use IAM Roles instead of IAM Users.
- Never hardcode AWS credentials inside EC2 instances.
- Grant only the minimum required permissions.
- Enable Instance Metadata Service Version 2 (IMDSv2).
- Regularly review attached IAM policies.

---

# Notes

- This module does not create an IAM Role.
- The IAM Role must already exist.
- The created Instance Profile is attached through the Launch Template.
- One IAM Role can be associated with one Instance Profile.

---

# Future Enhancements

- Multiple Role Support
- Cross-Account IAM Roles
- IAM Permission Boundaries
- IMDSv2 Enforcement
- Conditional IAM Attachments
- AWS Organizations Integration

---

# Key Learning Outcomes

- IAM Instance Profiles
- IAM Role Association
- Temporary AWS Credentials
- EC2 Authentication
- AWS Security Best Practices
- Terraform IAM Resources
- Enterprise Infrastructure Design