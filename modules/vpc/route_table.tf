resource "aws_default_route_table" "public_route_table" {
    default_route_table_id = aws_vpc.main.default_route_table_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = merge(local.common_tags, {
        Name = "${var.name}-rtb-public"
    }) 
}

resource "aws_route_table" "private_route_table" {
    count = local.max_subnet_length
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = element(aws_nat_gateway.nat_gw.*.id, count.index)
    }

    tags = merge(local.common_tags, {
        Name = "${var.name}-rtb-private${count.index}-${element(local.zone_names, count.index)}"
    }) 
}

resource "aws_route_table_association" "private_rtb" {
  count          = length(aws_subnet.private)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}
