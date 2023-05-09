locals {
    common_tags = {
        Terraform             = "true"
        Environment           = var.environment
    }
    aws_region = data.aws_region.current.name
}

data "aws_region" "current" {}
