locals {
  common_tags = {
    Terraform             = "true"
  }
  zone_names        = data.aws_availability_zones.available.names
  max_subnet_length = length(local.zone_names)
  nat_gateway_ips   = tolist(aws_eip.nat.*.id)
}

data "aws_availability_zones" "available" {
  state = "available"
}
