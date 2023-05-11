locals {
    common_tags = {
        Terraform             = "true"
        Environment           = var.environment
    }
    aws_region = data.aws_region.current.name
    
    cors_rules = try(jsondecode(var.cors_rule), var.cors_rule)
}

data "aws_region" "current" {}
