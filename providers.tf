terraform {
  required_version = ">=1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.58"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.15"
    }
  }
}