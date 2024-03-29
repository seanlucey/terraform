output "vpc_id" {
  value = aws_vpc.main.id
}

output "cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "nat_public_ips" {
  value = aws_eip.nat.*.public_ip
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "private_route_table_ids" {
  value = aws_route_table.private_route_table.*.id
}

output "main_route_table_id" {
  value = aws_vpc.main.main_route_table_id
}

output "s3_endpoint_id" {
  value = aws_vpc_endpoint.s3_endpoint.id
}
