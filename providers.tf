terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.43.0"
    }
    random = {
        source  = "hashicorp/random"
        version = "~> 3.5"
      }
  }
  required_version = "~> 1.14.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}


