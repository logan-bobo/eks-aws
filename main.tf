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

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.22.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.10.1"
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

provider "kubernetes" {
  host                   = aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", aws_eks_cluster.main.name]
  }
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", aws_eks_cluster.main.name]
    }
  }
}
