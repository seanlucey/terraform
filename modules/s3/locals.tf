locals {
    common_tags = {
        Terraform             = "true"
        Environment           = var.environment
    }
    aws_region = data.aws_region.current.name
    create_crr_bucket = var.create_crr_bucket
}

data "aws_region" "current" {}
