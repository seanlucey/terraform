resource "aws_vpc" "main" {
    cidr_block              = var.cidr_block
    enable_dns_support      = var.enable_dns_support
    enable_dns_hostnames    = var.enable_dns_hostnames

    tags = merge(local.common_tags, {
        Name = "${var.name}_vpc"
    })
}

# Create NAT Gateway and associate public IP address
resource "aws_eip" "nat" {
    count       = local.max_subnet_length
    vpc         = true
    tags = merge(local.common_tags, {
        Name = "${var.name}-eip$(count.index)"
    })
}

resource "aws_nat_gateway" "nat_gw" {
    count = local.max_subnet_length

    allocation_id       = length(local.nat_gateway_ips) > 0 ? element(local.nat_gateway_ips, count.index) : null
    subnet_id           = element(aws_subnet.public.*.id, count.index)
    connectivity_type   = "public"

    tags = merge(local.common_tags, {
        Name = "$(var.name)-natgw-${count.index}"
    })    
}

resource "aws_subnet" "private" {
    count               = local.max_subnet_length
    vpc_id              = aws_vpc.main.id
    availability_zone   = element(local.zone_names, count.index)
    cidr_block          = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + local.max_subnet_length)

    tags = merge(local.common_tags, {
        Name = "${var.name}_private_subnet_${element(local.zone_names, count.index)}"
        Tier = "Private"
    })

    timeouts {
        delete = "40m"
    }
}

resource "aws_subnet" "public" {
    count               = local.max_subnet_length
    vpc_id              = aws_vpc.main.id
    availability_zone   = element(local.zone_names, count.index)
    cidr_block          = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + local.max_subnet_length)

    tags = merge(local.common_tags, {
        Name = "${var.name}_public_subnet_${element(local.zone_names, count.index)}"
        Tier = "Public"
    })
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = merge(local.common_tags, {
        Name = "${var.name}_internet_gateway"
    })
}
