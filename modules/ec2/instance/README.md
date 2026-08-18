# EC2 Instance Module

## Overview

The EC2 Instance module provisions an Amazon EC2 instance using an AWS Launch Template. It is responsible for deploying the compute resource after all required dependencies, such as the AMI, IAM Instance Profile, Security Groups, and Launch Template, have been created.

This module supports both On-Demand and Spot Instances and follows an enterprise-ready, modular architecture that separates infrastructure components for better reusability and maintainability.

---

# Features

- Launch EC2 Instance using Launch Template
- On-Demand Instance Support
- Spot Instance Support
- Public or Private Subnet Deployment
- Optional Public IP Assignment
- Termination Protection
- Launch Template Versioning
- Enterprise-ready reusable design
- Resource Tagging

---

# Resources Created

This module creates the following AWS resource:

- aws_instance

---

# Architecture

```text
                Launch Template
                       │
                       │
         Contains EC2 Configuration
                       │
      ┌────────────────┼────────────────┐
      │                │                │
      ▼                ▼                ▼
     AMI          Instance Type   IAM Profile
      │                │                │
      └────────────────┼────────────────┘
                       │
                       ▼
                Amazon EC2 Instance
                       │
         ┌─────────────┴──────────────┐
         │                            │
         ▼                            ▼
     Elastic IP                 Additional EBS
```

---

# Input Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| enabled | Enable module | bool | Yes |
| project_name | Project name | string | Yes |
| environment | Environment | string | Yes |
| launch_template_id | Launch Template ID | string | Yes |
| launch_template_version | Launch Template Version | string | Yes |
| subnet_id | EC2 Subnet | string | Yes |
| associate_public_ip_address | Assign Public IP | bool | No |
| disable_api_termination | Enable Termination Protection | bool | No |
| tags | Resource Tags | map(string) | Yes |

---

# Output Values

| Name | Description |
|------|-------------|
| instance_id | EC2 Instance ID |
| instance_arn | EC2 Instance ARN |
| instance_public_ip | Public IP Address |
| instance_private_ip | Private IP Address |
| instance_state | Current Instance State |
| availability_zone | Availability Zone |

---

# Example Usage

```hcl
module "instance" {
  source = "../../modules/ec2/instance"

  enabled      = true
  project_name = var.project_name
  environment  = var.environment

  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.launch_template_latest_version

  subnet_id = module.subnets.public_subnet_ids[0]

  associate_public_ip_address = true

  disable_api_termination = false

  tags = local.common_tags
}
```

---

# Deployment Flow

```text
Terraform Apply
        │
        ▼
Read Launch Template
        │
        ▼
Create EC2 Instance
        │
        ▼
Assign Subnet
        │
        ▼
Assign Public IP (Optional)
        │
        ▼
Launch Instance
        │
        ▼
Return Instance Information
```

---

# Instance Lifecycle

```text
Pending
   │
   ▼
Running
   │
   ▼
Stopping
   │
   ▼
Stopped
   │
   ▼
Terminated
```

---

# Deployment Options

## On-Demand Instance

- Standard AWS pricing
- High availability
- Recommended for production workloads
- No interruption by AWS

---

## Spot Instance

- Uses unused EC2 capacity
- Up to 90% lower cost
- May be interrupted by AWS
- Suitable for development, testing, CI/CD, and fault-tolerant applications

---

# Networking

The EC2 instance can be launched in:

- Public Subnet
- Private Application Subnet

Depending on the subnet selection, the instance may receive:

- Public IP
- Private IP
- Elastic IP (through the Elastic IP module)

---

# Security Best Practices

- Deploy production instances in private subnets whenever possible.
- Use Security Groups to restrict inbound traffic.
- Enable termination protection for critical workloads.
- Use IAM Roles instead of long-term AWS credentials.
- Keep the operating system updated regularly.
- Enable detailed monitoring for production environments.

---

# Notes

- This module launches the EC2 instance using the Launch Template.
- It does not create the Launch Template itself.
- Additional storage is attached separately using the Volume Attachment module.
- A static public IP can be associated later using the Elastic IP module.

---

# Future Enhancements

- Auto Scaling Group Integration
- ECS Capacity Provider Integration
- ALB Target Group Registration
- Lifecycle Hooks
- Placement Groups
- Dedicated Hosts
- Capacity Reservations
- Instance Scheduler
- EC2 Auto Recovery

---

# Key Learning Outcomes

- Amazon EC2
- Launch Templates
- EC2 Networking
- Spot vs On-Demand Instances
- EC2 Lifecycle
- Infrastructure as Code (IaC)
- Enterprise Terraform Module Design
- AWS Compute Services