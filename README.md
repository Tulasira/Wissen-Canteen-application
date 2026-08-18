# Terraform AWS Enterprise Infrastructure Framework

## Overview

This project provisions a complete AWS infrastructure using Terraform following a highly modular, reusable, and enterprise-ready architecture.

The infrastructure follows AWS Well-Architected Framework best practices by separating networking, security, load balancing, storage, container orchestration, secrets management, monitoring, and database resources into independent Terraform modules.

The project is designed to be scalable, maintainable, reusable, and environment-independent, making it suitable for enterprise deployments across multiple environments.

---

# Architecture

```text
                                Internet
                                    │
                           Internet Gateway
                                    │
                        ┌───────────┴───────────┐
                        │                       │
                 Public Route Table      NAT Gateway (Optional)
                        │                       │
                Public Subnets          Private Route Table
                        │                       │
                        ▼                       ▼
                 Internet-facing ALB
                        │
                        ▼
               ECS Fargate Service
                        │
              ┌─────────┴─────────┐
              │                   │
              ▼                   ▼
        Auto Scaling        CloudWatch Alarms
        CPU / Memory         CPU / Memory
              │                   │
              ▼                   │
         ECS Tasks ◄──────────────┘
              │
              ▼
      Private Application Subnets
              │
              ▼
          Amazon RDS

---------------------------------------------------------

AWS Secrets Manager
        │
        ▼
Database Credentials
        │
        ▼
Amazon RDS

---------------------------------------------------------

VPC Flow Logs
        │
        ▼
CloudWatch Logs

---------------------------------------------------------

CloudWatch Log Group
        │
        ▼
ECS Container Logs

---------------------------------------------------------

Amazon S3
````

---

# Infrastructure Components

## Networking

* Virtual Private Cloud (VPC)
* Public Subnets
* Private Application Subnets
* Database Subnets
* Internet Gateway
* NAT Gateway (Reusable Module)
* Route Tables
* Routes
* Network ACLs
* Network ACL Rules
* VPC Flow Logs

---

## Container Platform

* Amazon ECS Cluster
* AWS Fargate
* ECS Service
* ECS Task Definition
* ECS Task Execution Role
* CloudWatch Log Group
* ALB Integration
* Private Subnet Deployment
* ECS Service Auto Scaling
* CPU-based Auto Scaling
* Memory-based Auto Scaling

---

## Load Balancing

* Application Load Balancer
* Internet-facing ALB
* Internal ALB
* Configurable AZ Deployment
* Target Group
* Listener
* Listener Rules

---

## Security

* Security Groups
* Security Group Rules
* Network ACLs
* AWS Secrets Manager
* Server-side Encryption
* IAM Role for Enhanced Monitoring
* ECS Task Execution IAM Role

---

## Storage

* Amazon S3
* Versioning
* Server-side Encryption (AES-256)
* Public Access Block
* Bucket Name Validation

---

## Database

* Amazon RDS
* DB Subnet Group
* Custom Parameter Group
* Custom Option Group
* Secrets Manager Integration
* IAM Database Authentication
* Performance Insights
* Standard Monitoring
* Enhanced Monitoring

---

## Monitoring

* VPC Flow Logs
* CloudWatch Logs
* ECS Container Logs
* RDS Enhanced Monitoring
* Performance Insights
* ECS CPU CloudWatch Alarm
* ECS Memory CloudWatch Alarm
* ECS Service CPU Monitoring
* ECS Service Memory Monitoring

---

# Project Structure

```text
terraform-enterprise-framework/
│
├── README.md
│
├── modules/
│
│   ├── alb/
│   │      ├── load_balancer/
│   │      ├── load_balancer_listener/
│   │      ├── load_balancer_listener_rule/
│   │      └── target_group/
│   │
│   ├── ecs/
│   │      ├── cluster/
│   │      ├── log-group/
│   │      ├── task-execution-role/
│   │      ├── task-definition/
│   │      ├── service/
│   │      ├── auto-scaling/
│   │      └── cloudwatch-alarm/
│   │
│   ├── rds/
│   │      ├── db-instance/
│   │      ├── db-monitoring/
│   │      ├── db-option-group/
│   │      ├── db-parameter-group/
│   │      └── db-subnet-group/
│   │
│   ├── s3/
│   │
│   ├── secrets-manager/
│   │
│   ├── security-group/
│   │      ├── security-group/
│   │      └── security-group-rule/
│   │
│   └── vpc/
│          ├── vpc/
│          ├── internet_gateway/
│          ├── nat_gateway/
│          ├── subnets/
│          ├── route_table/
│          ├── route/
│          ├── nacl/
│          ├── nacl_rule/
│          └── vpc-flow-log/
│
└── environments/
    ├── dev/
    ├── qa/
    └── prod/
```

---

# Module Design

The project follows a resource-level modular architecture.

Each AWS resource is implemented as an independent Terraform module to maximize reusability and maintainability.

The ECS platform is further divided into separate modules for the cluster, logging, task execution role, task definition, service, Auto Scaling, and CloudWatch alarms.

## Benefits

* Reusable modules
* Environment-independent deployments
* Easy troubleshooting
* Clear separation of responsibilities
* Enterprise-ready structure
* Scalable architecture
* Team collaboration support
* Independent monitoring and scaling components

---

# ECS Auto Scaling

The ECS Auto Scaling module configures automatic scaling for an existing ECS Service.

It supports:

* CPU-based Auto Scaling
* Memory-based Auto Scaling
* Configurable minimum task count
* Configurable maximum task count
* Independent CPU and memory scaling policies
* Enable or disable Auto Scaling

### Scaling Flow

```text
ECS Service
     ↓
Auto Scaling Target
     ↓
CPU / Memory Metrics
     ↓
Scaling Policies
     ↓
Increase / Decrease ECS Tasks
```

The minimum and maximum task count define the scaling range.

---

# ECS CloudWatch Alarms

The ECS CloudWatch Alarm module monitors CPU and memory utilization of an ECS Service.

It creates:

* CPU utilization alarm
* Memory utilization alarm

### Monitoring Flow

```text
ECS Service
     ↓
CloudWatch Metrics
     ↓
CPU / Memory Threshold
     ↓
CloudWatch Alarm
     ↓
Alarm State
```

The CPU and memory thresholds can be configured through Terraform variables.

---

# Security Features

* Private RDS deployment
* Public and Private subnet isolation
* ECS tasks deployed in Private Application Subnets
* Dedicated Network ACLs
* Dedicated Security Groups
* AWS Secrets Manager integration
* No hardcoded credentials
* Random password generation
* Storage encryption
* IAM Database Authentication
* Performance Insights
* Standard & Enhanced Monitoring
* S3 Public Access Block
* AES-256 Server-side Encryption
* Bucket Name Validation
* VPC Flow Logs
* ECS Task Execution IAM Role

---

# Deployment Flow

1. Create VPC
2. Create Internet Gateway
3. Create Public, Private Application, and Database Subnets
4. Create Route Tables
5. Create Routes
6. Create Network ACLs
7. Create Network ACL Rules
8. Create Security Groups
9. Create Security Group Rules
10. Create VPC Flow Logs
11. Create Amazon S3 Bucket
12. Create Secrets Manager Secret
13. Create DB Subnet Group
14. Create DB Parameter Group
15. Create DB Option Group
16. Create RDS Monitoring Role (when Enhanced Monitoring is enabled)
17. Create Amazon RDS
18. Create ECS Cluster
19. Create CloudWatch Log Group
20. Create ECS Task Execution Role
21. Create ECS Task Definition
22. Create ECS Service (AWS Fargate)
23. Create ECS Auto Scaling Target
24. Create CPU and Memory Scaling Policies
25. Create ECS CloudWatch CPU Alarm
26. Create ECS CloudWatch Memory Alarm
27. Create Application Load Balancer
28. Create Target Group
29. Create Listener
30. Create Listener Rules

---

# Current Environment

| Setting            | Value                         |
| ------------------ | ----------------------------- |
| Environment        | Dev                           |
| Region             | us-east-2                     |
| Database Engine    | MySQL 8.0                     |
| Container Platform | Amazon ECS Fargate            |
| Container Image    | nginx:latest                  |
| Load Balancer      | Application Load Balancer     |
| Monitoring         | Standard (Enhanced Supported) |
| Storage            | Amazon S3                     |
| Provisioning Tool  | Terraform                     |

---

# Terraform Commands

## Initialize

```bash
terraform init
```

## Format

```bash
terraform fmt -recursive
```

## Validate

```bash
terraform validate
```

## Plan

```bash
terraform plan -var-file="terraform.tfvars"
```

## Apply

```bash
terraform apply -var-file="terraform.tfvars"
```

## Destroy

```bash
terraform destroy -var-file="terraform.tfvars"
```

---

# Future Enhancements

* Multiple ECS Services
* Multi-Environment Support
* Remote Backend
* WAF Integration
* HTTPS Listener
* ACM Integration
* Route53 Integration
* CI/CD Pipeline
* Terraform Workspaces

---

# Key Learning Outcomes

* Terraform Module Design
* Infrastructure as Code (IaC)
* AWS Networking
* VPC Design
* Subnet Segmentation
* Network ACLs
* Security Groups
* Application Load Balancer
* Amazon ECS
* AWS Fargate
* ECS Service Auto Scaling
* CloudWatch Alarms
* Amazon RDS
* Amazon S3
* AWS Secrets Manager
* VPC Flow Logs
* CloudWatch Integration
* IAM Best Practices
* Reusable Terraform Modules
* Enterprise Infrastructure Design
* AWS Security Best Practices