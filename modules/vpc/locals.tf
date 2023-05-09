locals {
    common_tags = {
        Terraform             = "true"
        Environment           = var.environment
    }
    zone_names        = data.aws_availability_zones.available.names
    max_subnet_length = var.max_subnet_length
    nat_gateway_ips   = tolist(aws_eip.nat.*.id)
}

data "aws_availability_zones" "available" {
  state = "available"
}
