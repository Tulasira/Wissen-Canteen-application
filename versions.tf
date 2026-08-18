terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Configure a remote backend before running `terraform init` against a real
  # environment. Local state is fine to try this out, not for a team.
  #
  # backend "s3" {
  #   bucket         = "wissen-canteen-tfstate"
  #   key            = "canteen/terraform.tfstate"
  #   region         = "ap-south-1"
  #   dynamodb_table = "wissen-canteen-tf-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

# CloudFront's ACM certificate must be issued in us-east-1 regardless of the
# app's primary region — this alias is passed into modules/dns_acm.
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  default_tags {
    tags = local.common_tags
  }
}

data "aws_caller_identity" "current" {}
