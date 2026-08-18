# S3 Module

## Overview

This module provisions a secure and reusable Amazon S3 bucket using Terraform.

The module follows AWS security best practices by enabling server-side encryption, blocking all public access, supporting configurable bucket versioning, and validating bucket names according to AWS S3 naming requirements.

It is designed as a reusable Terraform module that can be deployed across multiple environments without modifying the module code.

---

## Purpose

This module provides a standardized way to provision secure Amazon S3 buckets.

The module:

- Creates an Amazon S3 bucket
- Validates bucket names using AWS naming rules
- Blocks all public access by default
- Supports configurable bucket versioning
- Enables server-side encryption
- Supports reusable infrastructure deployments

---

## Architecture Flow

```text
Terraform
      │
      ▼
terraform.tfvars
      │
      ▼
S3 Module
      │
      ▼
Amazon S3 Bucket
      │
 ┌────┼───────────────────────┐
 ▼    ▼                       ▼
Versioning     Server-Side Encryption
      │
      ▼
Public Access Block
```

---

## Resources Created

- `aws_s3_bucket`
- `aws_s3_bucket_public_access_block`
- `aws_s3_bucket_versioning`
- `aws_s3_bucket_server_side_encryption_configuration`

---

## Features

- Creates an Amazon S3 bucket
- AWS-compliant bucket name validation
- Blocks all public access
- Configurable bucket versioning
- Server-side encryption (SSE-S3)
- Environment-independent reusable module
- Common tagging strategy
- Secure-by-default configuration

---

## Inputs

| Name | Description |
|------|-------------|
| enabled | Enable or disable S3 bucket creation |
| bucket_name | Globally unique S3 bucket name |
| versioning_enabled | Enable or disable bucket versioning |
| tags | Common resource tags |

---

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | ID of the S3 bucket |
| bucket_name | Name of the S3 bucket |
| bucket_arn | ARN of the S3 bucket |

---

## Example Usage

```hcl
module "s3" {
  source = "../../modules/s3"

  enabled            = var.s3_enabled
  bucket_name        = var.s3_bucket_name
  versioning_enabled = var.s3_versioning_enabled

  tags = local.common_tags
}
```

---

## Security Features

- Blocks all public access
- Server-side encryption enabled using AES-256 (SSE-S3)
- Supports bucket versioning for object recovery
- Prevents accidental public exposure
- Validates bucket names before deployment

---

## Bucket Name Validation

The module validates bucket names according to AWS S3 naming requirements.

Validation includes:

- Length between **3 and 63 characters**
- Lowercase letters only
- Numbers allowed
- Hyphen (`-`) allowed
- Dot (`.`) allowed
- Must start and end with a lowercase letter or number
- Must not resemble an IPv4 address
- Uppercase letters are not allowed
- Underscores (`_`) are not allowed

This validation prevents deployment failures caused by invalid bucket names.

---

## Current Development Configuration

```hcl
s3_enabled            = true
s3_bucket_name        = "vpc-alb-rds-dev-vanshika-s3"
s3_versioning_enabled = true
```

The current deployment creates a private S3 bucket with versioning enabled, server-side encryption, and all public access blocked.

---

## Best Practices Implemented

- Modular Terraform design
- Reusable across environments
- Secure-by-default configuration
- Infrastructure validation before deployment
- Bucket versioning support
- Server-side encryption enabled
- Public access blocked
- Standard resource tagging
- AWS naming rule validation

---

## Related Modules

- vpc
- alb
- rds
- security-group

---

## Notes

- Bucket names must be globally unique across AWS.
- Versioning can be enabled or disabled through Terraform variables.
- Server-side encryption uses **AES-256 (SSE-S3)**.
- Public access is blocked by default to improve security.
- The module follows a reusable and environment-independent Terraform design.