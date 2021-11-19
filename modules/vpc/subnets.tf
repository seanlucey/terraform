locals {
  cidr_block_a  = cidrsubnet(aws_vpc.main.cidr_block, 2, 0)
  cidr_block_b = cidrsubnet(aws_vpc.main.cidr_block, 2, 1)
  cidr_block_c = cidrsubnet(aws_vpc.main.cidr_block, 2, 2)
}

resource "aws_subnet" "sn_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.cidr_block_a
  availability_zone = "${var.AWS_REGION}a"
  tags = {
    Name = "Main_Subnet_A"
  }
}
resource "aws_subnet" "sn_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.cidr_block_b
  availability_zone = "${var.AWS_REGION}b"
  tags = {
    Name = "Main_Subnet_B"
  }
}
resource "aws_subnet" "sn_c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.cidr_block_c
  availability_zone = "${var.AWS_REGION}c"
  tags = {
    Name = "Main_Subnet_C"
  }
}
