# AMI Module

## Overview

The AMI module is responsible for selecting the Amazon Machine Image (AMI) used to launch EC2 instances.

It supports both automatic AMI discovery for commonly used operating systems and user-defined custom AMIs, making the module flexible for enterprise environments.

---

# Features

- Automatic latest AMI lookup
- Amazon Linux 2023 support
- Ubuntu 22.04 LTS support
- Custom AMI support
- Enterprise-ready reusable module
- No hardcoded AMI IDs
- Region-aware AMI lookup

---

# Supported Operating Systems

| Operating System | Supported |
|------------------|-----------|
| Amazon Linux 2023 | ✅ |
| Ubuntu 22.04 LTS | ✅ |
| Custom AMI | ✅ |

---

# Resources Used

This module uses the following Terraform data sources:

- `aws_ami`

No AWS resources are created by this module.

It only discovers and returns the appropriate AMI ID.

---

# Module Architecture

```text
User Input
     │
     │
     ▼
OS Type
(amazon-linux / ubuntu)
     │
     ▼
AWS AMI Lookup
     │
     ▼
Latest AMI
     │
     ▼
AMI ID Output
```

---

# Input Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| enabled | Enable or disable module | bool | Yes |
| os_type | Operating system type | string | Yes |
| custom_ami_id | Custom AMI ID (optional) | string | No |

---

# Output Values

| Name | Description |
|------|-------------|
| ami_id | Selected AMI ID |

---

# Example Usage

```hcl
module "ami" {
  source = "../../modules/ec2/ami"

  enabled       = true
  os_type       = "ubuntu"
  custom_ami_id = ""

}
```

Example using custom AMI:

```hcl
module "ami" {
  source = "../../modules/ec2/ami"

  enabled       = true
  os_type       = "ubuntu"
  custom_ami_id = "ami-0123456789abcdef0"

}
```

---

# Selection Logic

The module follows the decision flow below:

```text
Custom AMI Provided?
        │
   ┌────┴────┐
   │         │
 Yes         No
   │         │
   ▼         ▼
Use Custom   Lookup Latest AMI
AMI ID       based on OS Type
```

---

# Best Practices

- Avoid hardcoding AMI IDs unless required.
- Use the latest supported operating system images.
- Use custom AMIs only for golden image deployments.
- Keep operating systems updated regularly.
- Use enterprise-approved AMIs for production workloads.

---

# Notes

- Amazon Linux AMIs are owned by Amazon.
- Ubuntu AMIs are owned by Canonical.
- The module always retrieves the latest available image unless a custom AMI is specified.
- The selected AMI is passed to the Launch Template module.

---

# Future Enhancements

- Windows Server support
- RHEL support
- SUSE Linux support
- ARM64 AMI support
- GPU AMI support
- CIS Hardened AMIs
- Image Builder Integration
- Marketplace AMI support

---

# Key Learning Outcomes

- Amazon Machine Images (AMI)
- AWS Data Sources
- Dynamic Infrastructure
- Terraform Data Blocks
- Operating System Selection
- Enterprise Infrastructure Design