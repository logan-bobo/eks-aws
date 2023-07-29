locals {
  main_vpc_cidr = "10.0.0.0/16"
  subnets = {
    public_01  = "10.0.1.0/24"
    public_02  = "10.0.2.0/24"
    private_01 = "10.0.3.0/24"
    private_02 = "10.0.4.0/24"
  }
}

resource "aws_vpc" "main" {
  cidr_block = local.main_vpc_cidr
}

resource "aws_subnet" "main" {
  for_each = local.subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
}