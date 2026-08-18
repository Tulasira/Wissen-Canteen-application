# Launch Template Module

## Overview

The Launch Template module creates an Amazon EC2 Launch Template that defines the configuration required to launch EC2 instances consistently across environments.

A Launch Template acts as a reusable blueprint containing the AMI, instance type, networking, storage, IAM instance profile, SSH key pair, monitoring settings, user data, and Spot Instance configuration.

This module enables standardized, repeatable, and enterprise-ready EC2 deployments.

---

# Features

- Launch Template Creation
- Dynamic AMI Support
- Amazon Linux & Ubuntu Support
- Custom AMI Support
- On-Demand Instance Support
- Spot Instance Support
- IAM Instance Profile Integration
- Security Group Association
- SSH Key Pair Integration
- Root Volume Configuration
- EBS Encryption
- Detailed Monitoring
- User Data Support
- Tag Specifications
- Enterprise-ready reusable design

---

# Resources Created

This module creates the following AWS resource:

- aws_launch_template

---

# Architecture

```text
                 Launch Template

            ┌────────────────────┐
            │      AMI ID        │
            ├────────────────────┤
            │   Instance Type    │
            ├────────────────────┤
            │     Key Pair       │
            ├────────────────────┤
            │ Security Groups    │
            ├────────────────────┤
            │ IAM Profile        │
            ├────────────────────┤
            │ User Data          │
            ├────────────────────┤
            │ Root EBS Volume    │
            ├────────────────────┤
            │ Spot Configuration │
            └─────────┬──────────┘
                      │
                      ▼
               EC2 Instance
```

---

# Input Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| enabled | Enable module | bool | Yes |
| project_name | Project name | string | Yes |
| environment | Environment | string | Yes |
| ami_id | AMI ID | string | Yes |
| instance_type | EC2 Instance Type | string | Yes |
| key_name | EC2 Key Pair | string | Yes |
| security_group_ids | Security Groups | list(string) | Yes |
| iam_instance_profile | IAM Instance Profile | string | No |
| user_data | EC2 Startup Script | string | No |
| ebs_optimized | Enable EBS Optimization | bool | No |
| monitoring_enabled | Enable Detailed Monitoring | bool | No |
| volume_size | Root Volume Size | number | Yes |
| volume_type | Root Volume Type | string | Yes |
| encrypted | Enable Root Volume Encryption | bool | No |
| delete_on_termination | Delete Root Volume | bool | No |
| spot_instance | Launch Spot Instance | bool | Yes |
| tags | Resource Tags | map(string) | Yes |

---

# Output Values

| Name | Description |
|------|-------------|
| launch_template_id | Launch Template ID |
| launch_template_name | Launch Template Name |
| launch_template_latest_version | Latest Template Version |

---

# Example Usage

```hcl
module "launch_template" {
  source = "../../modules/ec2/launch-template"

  enabled      = true
  project_name = var.project_name
  environment  = var.environment

  ami_id        = module.ami.ami_id
  instance_type = "t3.micro"

  key_name = module.key_pair.key_name

  security_group_ids = [
    module.ec2_security_group.security_group_id
  ]

  iam_instance_profile = module.instance_profile.instance_profile_name

  volume_size = 20
  volume_type = "gp3"

  encrypted = true

  monitoring_enabled = true

  spot_instance = false

  tags = local.common_tags
}
```

---

# Deployment Flow

```text
Terraform Apply
        │
        ▼
Select AMI
        │
        ▼
Attach Key Pair
        │
        ▼
Attach Security Groups
        │
        ▼
Attach IAM Instance Profile
        │
        ▼
Configure Root Volume
        │
        ▼
Configure Monitoring
        │
        ▼
Create Launch Template
        │
        ▼
Launch EC2 Instance
```

---

# Root Volume Configuration

The Launch Template defines the root EBS volume attached to every EC2 instance.

Supported options include:

- Volume Size
- Volume Type
- Encryption
- Delete on Termination
- EBS Optimization

---

# Spot Instance Support

The module supports both deployment models:

### On-Demand

- Standard EC2 deployment
- Highest availability
- Predictable pricing

### Spot

- Uses unused AWS capacity
- Up to 90% lower cost
- Best suited for fault-tolerant workloads

The deployment type can be switched using a single Terraform variable.

---

# User Data

The Launch Template supports EC2 User Data scripts.

Typical use cases include:

- Install NGINX
- Install Docker
- Install CloudWatch Agent
- Configure ECS Agent
- Bootstrap Applications
- Execute Initialization Scripts

---

# Security Best Practices

- Use encrypted EBS volumes.
- Enable detailed monitoring for production.
- Use IAM Roles instead of Access Keys.
- Store startup scripts in version control.
- Use reusable Launch Templates across environments.
- Enable IMDSv2 where applicable.

---

# Notes

- This module creates only the Launch Template.
- It does not launch an EC2 instance.
- The EC2 Instance module consumes this Launch Template.
- Root storage is defined here.
- Additional EBS volumes are managed separately.

---

# Future Enhancements

- Launch Template Versioning
- Mixed Instance Policies
- Auto Scaling Group Integration
- ECS Capacity Provider Integration
- Metadata Options (IMDSv2)
- Placement Groups
- Capacity Reservations
- Nitro Enclaves Support

---

# Key Learning Outcomes

- Amazon EC2 Launch Templates
- Infrastructure Standardization
- Root EBS Configuration
- Spot Instances
- IAM Instance Profiles
- User Data
- EC2 Monitoring
- Enterprise Terraform Module Design