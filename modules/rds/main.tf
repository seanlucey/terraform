data "aws_partition" "current" {}

data "aws_iam_policy_document" "monitoring_rds_assume_role" {
  count = local.create_monitoring_role ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

resource "aws_db_subnet_group" "default" {
    count = var.create_db_subnet_group ? 1 : 0
    
    name        = var.db_subnet_group_name
    description = "Allowed subnets for DB cluster instances"
    subnet_ids  = var.subnets
    
    tags = merge(local.common_tags, {
        Name = var.db_subnet_group_name
    })
}

resource "aws_rds_cluster" "rds_cluster" {
    allocated_storage = var.allocated_storage
    allow_major_version_upgrade = var.allow_major_version_upgrade
    apply_immediately = var.apply_immediately
    availability_zones = var.availability_zones
    backup_retention_period = var.backup_retention_period
    cluster_identifier = var.cluster_use_name_prefix ? null : var.name
    copy_tags_to_snapshot = var.copy_tags_to_snapshot
    database_name = var.is_primary_cluster ? var.database_name : null
    db_cluster_instance_class = local.is_serverless ? null : var.db_cluster_instance_class
    db_cluster_parameter_group_name = var.create_db_cluster_parameter_group ? aws_rds_cluster_parameter_group.default[0].id : var.db_cluster_parameter_group_name
    db_instance_parameter_group_name = var.allow_major_version_upgrade ? var.db_cluster_db_instance_parameter_group_name : null
    db_subnet_group_name = local.db_subnet_group_name
    deletion_protection = var.deletion_protection
    enable_global_write_forwarding = var.enable_global_write_forwarding
    enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
    enable_http_endpoint = var.enable_http_endpoint
    engine = var.engine
    engine_mode = var.engine_mode
    engine_version = var.engine_version
    final_snapshot_identifier = "${var.environment}-aurora-final-snapshot-${local.timestamp}"
    global_cluster_identifier = var.global_cluster_identifier
    iam_database_authentication_enabled = var.iam_database_authentication_enabled
    iops = var.iops
    kms_key_id = var.kms_key_id
    manage_master_user_password = var.global_cluster_identifier == null && var.manage_master_user_password ? var.manage_master_user_password : null
    master_user_secret_kms_key_id = var.global_cluster_identifier == null && var.manage_master_user_password ? var.master_user_secret_kms_key_id : null
    master_password = var.is_primary_cluster && !var.manage_master_user_password ? var.master_password : null
    master_username = var.is_primary_cluster ? var.master_username : null
    network_type = var.network_type
    port = var.port
    preferred_backup_window = local.is_serverless ? null : var.preferred_backup_window
    preferred_maintenance_window = local.is_serverless ? null : var.preferred_maintenance_window
    replication_source_identifier = var.replication_source_identifier

    dynamic "restore_to_point_in_time" {
        for_each = length(var.restore_to_point_in_time) > 0 ? [var.restore_to_point_in_time] : []

        content {
        restore_to_time            = try(restore_to_point_in_time.value.restore_to_time, null)
        restore_type               = try(restore_to_point_in_time.value.restore_type, null)
        source_cluster_identifier  = restore_to_point_in_time.value.source_cluster_identifier
        use_latest_restorable_time = try(restore_to_point_in_time.value.use_latest_restorable_time, null)
        }
    }

    dynamic "s3_import" {
        for_each = length(var.s3_import) > 0 && !local.is_serverless ? [var.s3_import] : []

        content {
        bucket_name           = s3_import.value.bucket_name
        bucket_prefix         = try(s3_import.value.bucket_prefix, null)
        ingestion_role        = s3_import.value.ingestion_role
        source_engine         = "mysql"
        source_engine_version = s3_import.value.source_engine_version
        }
    }

    dynamic "scaling_configuration" {
        for_each = length(var.scaling_configuration) > 0 && local.is_serverless ? [var.scaling_configuration] : []

        content {
        auto_pause               = try(scaling_configuration.value.auto_pause, null)
        max_capacity             = try(scaling_configuration.value.max_capacity, null)
        min_capacity             = try(scaling_configuration.value.min_capacity, null)
        seconds_until_auto_pause = try(scaling_configuration.value.seconds_until_auto_pause, null)
        timeout_action           = try(scaling_configuration.value.timeout_action, null)
        }
    }

    dynamic "serverlessv2_scaling_configuration" {
        for_each = length(var.serverlessv2_scaling_configuration) > 0 && var.engine_mode == "provisioned" ? [var.serverlessv2_scaling_configuration] : []

        content {
        max_capacity = serverlessv2_scaling_configuration.value.max_capacity
        min_capacity = serverlessv2_scaling_configuration.value.min_capacity
        }
    }

    skip_final_snapshot = var.skip_final_snapshot
    snapshot_identifier = var.snapshot_identifier
    source_region = var.source_region
    storage_encrypted = var.storage_encrypted
    storage_type = var.storage_type
    vpc_security_group_ids = compact(concat([try(aws_security_group.rds_sg[0].id, "")], var.vpc_security_group_ids))

    tags = merge(local.common_tags, {
        Name = "${var.name}-${var.environment}"#-${element(local.zone_names, count.index)}"
    })

    timeouts {
        create = try(var.cluster_timeouts.create, null)
        update = try(var.cluster_timeouts.update, null)
        delete = try(var.cluster_timeouts.delete, null)
    }

    lifecycle {
        ignore_changes = [
        replication_source_identifier,
        global_cluster_identifier,
        snapshot_identifier,
        ]
    }

    depends_on = [aws_cloudwatch_log_group.this]
}

resource "aws_rds_cluster_instance" "rds_instance" {
  for_each = { for k, v in var.instances : k => v if !local.is_serverless }

  apply_immediately = try(each.value.apply_immediately, var.apply_immediately)
  auto_minor_version_upgrade = try(each.value.auto_minor_version_upgrade, var.auto_minor_version_upgrade)
  availability_zone = try(each.value.availability_zone, null)
  ca_cert_identifier = var.ca_cert_identifier
  cluster_identifier = aws_rds_cluster.rds_cluster.id
  copy_tags_to_snapshot = try(each.value.copy_tags_to_snapshot, var.copy_tags_to_snapshot)
  db_parameter_group_name = var.create_db_parameter_group ? aws_db_parameter_group.default[0].id : var.db_parameter_group_name
  db_subnet_group_name = local.db_subnet_group_name
  engine = var.engine
  engine_version = var.engine_version
  identifier                            = var.instances_use_identifier_prefix ? null : try(each.value.identifier, "${var.name}-${each.key}")
  identifier_prefix                     = var.instances_use_identifier_prefix ? try(each.value.identifier_prefix, "${var.name}-${each.key}-") : null
  instance_class                        = try(each.value.instance_class, var.instance_class)
  monitoring_interval                   = try(each.value.monitoring_interval, var.monitoring_interval)
  monitoring_role_arn                   = var.create_monitoring_role ? try(aws_iam_role.rds_enhanced_monitoring[0].arn, null) : var.monitoring_role_arn
  performance_insights_enabled          = try(each.value.performance_insights_enabled, var.performance_insights_enabled)
  performance_insights_kms_key_id       = try(each.value.performance_insights_kms_key_id, var.performance_insights_kms_key_id)
  performance_insights_retention_period = try(each.value.performance_insights_retention_period, var.performance_insights_retention_period)
  preferred_maintenance_window = try(each.value.preferred_maintenance_window, var.preferred_maintenance_window)
  promotion_tier               = try(each.value.promotion_tier, null)
  publicly_accessible          = try(each.value.publicly_accessible, var.publicly_accessible)
      
  tags = merge(local.common_tags, {
        Name = "${var.name}-${var.environment}-${local.zone_names}"#-${element(local.zone_names, count.index)}"
    })

  timeouts {
    create = try(var.instance_timeouts.create, null)
    update = try(var.instance_timeouts.update, null)
    delete = try(var.instance_timeouts.delete, null)
  }
}

resource "aws_rds_cluster_endpoint" "cluster_endpoint" {
  for_each = { for k, v in var.endpoints : k => v if !local.is_serverless }

  cluster_endpoint_identifier = each.value.identifier
  cluster_identifier = aws_rds_cluster.rds_cluster.id
  custom_endpoint_type = each.value.type
  excluded_members = try(each.value.excluded_members, null)
  static_members = try(each.value.static_members, null)
  tags = merge(local.common_tags, {
        Name = "${var.name}-${var.environment}-cluster-endpoint"#${element(local.zone_names, count.index)}"
    })

  depends_on = [
    aws_rds_cluster_instance.rds_instance
  ]
}