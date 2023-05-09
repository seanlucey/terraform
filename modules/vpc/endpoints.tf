data "aws_region" "current_region" {}

resource "aws_vpc_endpoint" "s3_endpoint" {
    count = var.s3_endpoint_enable ? 1 : 0

    vpc_id = aws_vpc.main.id
    vpc_endpoint_type = "Gateway"
    service_name      = "com.amazonaws.${data.aws_region.current_region.name}.s3"
    route_table_ids = aws_route_table.private_route_table.ids
}
