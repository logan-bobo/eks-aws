locals {
  default_region = "eu-west-1"
  main_vpc_cidr  = "10.0.0.0/16"
  subnets = {
    public = {
      01 = {
        az   = "a",
        cidr = cidrsubnet(local.main_vpc_cidr, 8, 0)
      }
      02 = {
        az   = "b",
        cidr = cidrsubnet(local.main_vpc_cidr, 8, 1)
      }
    }
    private = {
      01 = {
        az   = "a",
        cidr = cidrsubnet(local.main_vpc_cidr, 8, 2)
      }
      02 = {
        az   = "b",
        cidr = cidrsubnet(local.main_vpc_cidr, 8, 3)
      }
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block = local.main_vpc_cidr
}

resource "aws_subnet" "public" {
  for_each = local.subnets.public

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = "${local.default_region}${each.value.az}"
}

resource "aws_subnet" "private" {
  for_each = local.subnets.private

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = "${local.default_region}${each.value.az}"
}
