terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.61"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

provider "aws" {
  region = local.secondary_region
  
  alias = "secondary"
}
