locals {
  default_region = "eu-west-1"
  main_vpc_cidr = "10.0.0.0/16"
  subnets = {
    public_01  = {
        az   = "a", 
        cidr = cidrsubnet(local.main_vpc_cidr, 8, 0)
    }
    public_02  = {
        az   = "b", 
        cidr = cidrsubnet(local.main_vpc_cidr, 8, 1)
    }
    private_01 = {
        az   = "a", 
        cidr = cidrsubnet(local.main_vpc_cidr, 8, 2)
    }
    private_02 = {
        az   = "b", 
        cidr = cidrsubnet(local.main_vpc_cidr, 8, 3)
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block = local.main_vpc_cidr
}

resource "aws_subnet" "main" {
  for_each = local.subnets
  
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = "${local.default_region}${each.value.az}"
}

