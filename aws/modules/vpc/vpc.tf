resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = var.name_vpc
  })

}

resource "aws_eip" "nat" {
  count = local.max_subnet_length
  vpc = true
  tags = merge(local.common_tags, {
    Name = var.name-eip${count.index}
  })
}

resource "aws_nat_gateway" "nat_gw" {
  count = local.max_subnet_length

  allocation_id     = length(local.nat_gateway_ips) > 0 ? element(local.nat_gateway_ips, count.index) : null
  subnet_id         = element(aws_subnet.public.*.id, count.index)
  connectivity_type = "public"

  tags = merge(local.common_tags, {
    Name = var.name-natgw-${count.index}
  })

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_subnet" "private" {
  count             = local.max_subnet_length
  vpc_id            = aws_vpc.main.id
  availability_zone = element(local.zone_names, count.index)
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)

  tags = merge(local.common_tags, {
    Name = var.name_private_subnet_${element(local.zone_names, count.index)}
    Tier = "Private"
  })

  timeouts {
    delete = "40m"
  }
}

resource "aws_subnet" "public" {
  count             = local.max_subnet_length
  vpc_id            = aws_vpc.main.id
  availability_zone = element(local.zone_names, count.index)
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + local.max_subnet_length)

  tags = merge(local.common_tags, {
    Name = var.name_public_subnet_${element(local.zone_names, count.index)}
    Tier = "Public"
  })
}

resource "aws_internet_gateway" "gw" {

  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = var.name_internet_gateway
  })
}
