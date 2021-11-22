resource "aws_vpc" "vpc" {
  cidr_block       = cidrsubnet(var.vpc_cidr_block, 0, 0)
  instance_tenancy = "default"
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  tags = {
    Name = var.vpc_name != "" ? lower(var.vpc_name)
  }
}
