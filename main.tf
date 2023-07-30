terraform {
  backend "s3" {
    bucket = "learn-eks-qwe"
    key    = "state"
    region = "eu-west-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      project = "learning-eks"
    }
  }
}
