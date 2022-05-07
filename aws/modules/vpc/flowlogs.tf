resource "aws_flow_log" "flow_logs" {
  count           = 1
  iam_role_arn    = aws_iam_role.flow_logs[0].arn
  log_destination = aws_cloudwatch_log_group.flow_logs[0].arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
  tags            = local.common_tags
}

resource "aws_cloudwatch_log_group" "flow_logs" {
  count = 1
  name              = var.name_flow_logs"
  retention_in_days = 30
  tags              = local.common_tags
}

resource "aws_iam_role" "flow_logs" {
  count              = 1
  name               = var.name_flow_logs"
  assume_role_policy = data.aws_iam_policy_document.vpc_flow_logs_service_principal[0].json
  tags               = local.common_tags
}

data "aws_iam_policy_document" "vpc_flow_logs_service_principal" {
  count = 1
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "vpc_metrics_flow_logs_write_policy_attach" {
  count      = 1
  role       = aws_iam_role.flow_logs[0].name
  policy_arn = aws_iam_policy.vpc_metrics_flow_logs_write_policy[0].arn
}

resource "aws_iam_policy" "vpc_metrics_flow_logs_write_policy" {
  count       = 1
  name        = "VpcMetricsFlowLogsWrite"
  description = "IAM policy for writing flow logs in CloudWatch"
  path        = "/"
  policy      = data.aws_iam_policy_document.vpc_metrics_flow_logs_write[0].json
  tags        = local.common_tags
}

data "aws_iam_policy_document" "vpc_metrics_flow_logs_write" {

  count = 1
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]

    resources = [
      aws_cloudwatch_log_group.flow_logs[0].arn,
      "${aws_cloudwatch_log_group.flow_logs[0].arn}:log-stream:*"
    ]
  }
}
