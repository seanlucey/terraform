resource "aws_security_group" "rds_sg" {
  count = var.create_security_group ? 1 :0

  name        = var.security_group_use_name_prefix ? null : var.name
  name_prefix = var.security_group_use_name_prefix ? "${var.name}-" : null
  vpc_id      = var.vpc_id
  description = coalesce(var.security_group_description, "Control traffic to/from RDS Aurora ${var.name}")

  tags = merge(local.common_tags, {
    Name = var.security_group_use_name_prefix ? null : var.name
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "this" {
  for_each = { for k, v in var.security_group_rules : k => v if var.create_security_group }

  type              = try(each.value.type, "ingress")
  from_port         = try(each.value.from_port, local.port)
  to_port           = try(each.value.to_port, local.port)
  protocol          = try(each.value.protocol, "tcp")
  security_group_id = aws_security_group.rds_sg[0].id

  cidr_blocks              = try(each.value.cidr_blocks, null)
  description              = try(each.value.description, null)
  ipv6_cidr_blocks         = try(each.value.ipv6_cidr_blocks, null)
  prefix_list_ids          = try(each.value.prefix_list_ids, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
}