resource "aws_default_route_table" "public_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "${var.vpc_cidr_block}"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Route Table"
  }
}
