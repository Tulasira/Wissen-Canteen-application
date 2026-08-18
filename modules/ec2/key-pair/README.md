# Key Pair Module

## Overview

The Key Pair module is responsible for creating or using an existing Amazon EC2 Key Pair for secure SSH access.

It supports automatic RSA key generation using Terraform, optional local storage of the private key, and the ability to reuse an existing key pair, making it suitable for enterprise environments.

---

# Features

- Create new EC2 Key Pair
- Use existing Key Pair
- Automatic RSA 4096-bit key generation
- Private key stored locally
- Public key uploaded to AWS
- Enterprise-ready reusable module
- Secure SSH authentication
- Optional key pair creation

---

# Resources Created

This module creates the following resources when enabled:

- tls_private_key
- aws_key_pair
- local_file (Private Key)

---

# Module Architecture

```text
                User Input
                     │
      ┌──────────────┴──────────────┐
      │                             │
Create New Key Pair?          Use Existing Key Pair
      │                             │
      ▼                             ▼
Generate RSA Key              Existing Key Name
      │
      ▼
Upload Public Key to AWS
      │
      ▼
Save Private Key Locally
      │
      ▼
Return Key Name
```

---

# Input Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| enabled | Enable module | bool | Yes |
| create_key_pair | Create a new key pair | bool | Yes |
| key_name | Name of the key pair | string | Yes |
| tags | Resource tags | map(string) | Yes |

---

# Output Values

| Name | Description |
|------|-------------|
| key_name | EC2 Key Pair name |
| private_key_path | Local path of generated private key |
| private_key_pem | Generated private key (Sensitive) |

---

# Example Usage

### Create a New Key Pair

```hcl
module "key_pair" {
  source = "../../modules/ec2/key-pair"

  enabled         = true
  create_key_pair = true
  key_name        = "enterprise-dev-key"

  tags = local.common_tags
}
```

---

### Use an Existing Key Pair

```hcl
module "key_pair" {
  source = "../../modules/ec2/key-pair"

  enabled         = true
  create_key_pair = false
  key_name        = "existing-key"

  tags = local.common_tags
}
```

---

# Workflow

```text
Terraform Apply
        │
        ▼
Generate RSA Key
        │
        ▼
Create AWS Key Pair
        │
        ▼
Save Private Key
        │
        ▼
Attach Key Pair to EC2
```

---

# Security Best Practices

- Never commit private keys to Git repositories.
- Restrict file permissions (chmod 400) before SSH access.
- Rotate SSH keys periodically.
- Use AWS Systems Manager (SSM) instead of SSH whenever possible.
- Store sensitive keys securely using a secrets management solution.

---

# Notes

- If `create_key_pair = true`, Terraform generates a new RSA key pair.
- If `create_key_pair = false`, an existing AWS Key Pair is used.
- The generated private key is marked as sensitive.
- The Key Pair is later attached through the Launch Template.

---

# Future Enhancements

- ED25519 Key Support
- AWS KMS Integration
- Secrets Manager Integration
- Automatic Key Rotation
- Key Expiration Policy
- Multi-user Key Management

---

# Key Learning Outcomes

- Amazon EC2 Key Pairs
- TLS Private Key Generation
- SSH Authentication
- AWS Key Pair Management
- Terraform TLS Provider
- Infrastructure Security