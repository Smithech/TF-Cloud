terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.83.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
  # required_version = "1.10.4"
  # required_version = "~>1.10.0"
}

provider "aws" {
  # Configuration options
  region = "us-east-1"

  default_tags {
    tags = var.tags
  }
}
