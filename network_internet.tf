# internet.tf


resource "aws_subnet" "public" {
  vpc_id = data.aws_vpc.default.id
  ipv6_cidr_block = "2600:1f18:7b3f:4210::/64"
  cidr_block = "172.31.128.0/20"
  availability_zone = "${data.aws_region.current.name}a"
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.default.id
  tags = {
    Name = "internet-gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = data.aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.eigw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_route_table.id
}






resource "aws_egress_only_internet_gateway" "eigw" {
  vpc_id = data.aws_vpc.default.id
  tags = {
    Name = "egress-only-internet-gateway"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "NAT Gateway"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "NAT Gateway"
  }
  depends_on = [
    aws_internet_gateway.igw,
  ]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = data.aws_vpc.default.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  route {
    ipv6_cidr_block = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.eigw.id
  }
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  for_each = toset(data.aws_subnets.default.ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.private_route_table.id
}
