resource "aws_vpc" "vpc" {
  cidr_block       = "${var.cidr_block}"
  instance_tenancy = "default"
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  tags = {
    Name = var.vpc_name != "" ? lower(var.vpc_name) : "${lower(var.name)}"
  }
}
