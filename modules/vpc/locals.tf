locals {
    common_tags = {
        Terraform             = "true"
        Environment           = var.environment
    }
    zone_names        = data.aws_availability_zones.available.names
    max_subnet_length = length(local.zone_names)
    nat_gateway_ips   = tolist(aws_eip.nat.*.id)

    cidr_block_a  = cidrsubnet(aws_vpc.main.cidr_block, 2, 0)
    cidr_block_b = cidrsubnet(aws_vpc.main.cidr_block, 2, 1)
    cidr_block_c = cidrsubnet(aws_vpc.main.cidr_block, 2, 2)
}

data "aws_availability_zones" "available" {
  state = "available"
}