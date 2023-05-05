locals {
    common_tags = {
        Terraform             = "true"
        Environment           = var.environment
    }

    is_serverless = var.engine_mode == "serverless"
    port = coalesce(var.port, (var.engine == "aurora-postgresql" || var.engine == "postgres" ? 5432 : 3306))

    timestamp = "${timestamp()}"
    zone_names = data.aws_availability_zones.available.names

    create_monitoring_role = var.create_monitoring_role && var.monitoring_interval > 0
    cluster_parameter_group_name = try(coalesce(var.db_cluster_parameter_group_name, var.name), null)
    db_parameter_group_name = try(coalesce(var.db_parameter_group_name, var.name), null)
    
    internal_db_subnet_group_name = try(coalesce(var.db_subnet_group_name, var.name), "")
    db_subnet_group_name = var.create_db_subnet_group ? try(aws_db_subnet_group.default[0].name, null) : local.internal_db_subnet_group_name
}

data "aws_availability_zones" "available" {
  state = "available"
}
