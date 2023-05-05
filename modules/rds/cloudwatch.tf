resource "aws_cloudwatch_log_group" "this" {
  for_each = toset([for log in var.enabled_cloudwatch_logs_exports : log if var.create_cloudwatch_log_group && !var.cluster_use_name_prefix])

  name              = "/aws/rds/cluster/${var.name}/${each.value}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_key_id

  tags = merge(local.common_tags, {
    Name = "/aws/rds/cluster/${var.name}/${each.value}"
  })
}