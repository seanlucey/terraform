resource "aws_iam_role" "rds_enhanced_monitoring" {
  count = local.create_monitoring_role ? 1 : 0

  name = var.iam_role_use_name_prefix ? null : var.iam_role_name
  name_prefix = var.iam_role_use_name_prefix ? "${var.iam_role_name}-" : null
  description = var.iam_role_description
  path = var.iam_role_path

  assume_role_policy = data.aws_iam_policy_document.monitoring_rds_assume_role[0].json
  managed_policy_arns = var.iam_role_managed_policy_arns
  permissions_boundary = var.iam_role_permissions_boundary
  force_detach_policies = var.iam_role_force_detach_policies
  max_session_duration = var.iam_role_max_session_duration

  tags = merge(local.common_tags, {
      Name = var.iam_role_use_name_prefix ? null : var.iam_role_name
  })
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  count = local.create_monitoring_role ? 1 : 0

  role = aws_iam_role.rds_enhanced_monitoring[0].name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}