locals {
    common_tags = {
        Terraform             = "true"
        Environment           = var.environment
    }
    zone_names        = data.aws_availability_zones.available.names
    create_bucket = var.create_bucket
}

data "aws_availability_zones" "available" {
  state = "available"
}
