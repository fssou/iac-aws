# network_subnets.tf

resource "aws_subnet" "public" {
  vpc_id            = data.aws_vpc.default.id
  ipv6_cidr_block   = "2600:1f18:7b3f:4210::/64"
  cidr_block        = "172.31.96.0/20"
  availability_zone = "${data.aws_region.current.name}a"
  tags = {
    Name = "public-a"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = data.aws_vpc.default.id
  ipv6_cidr_block   = "2600:1f18:7b3f:4220::/64"
  cidr_block        = "172.31.112.0/20"
  availability_zone = "${data.aws_region.current.name}a"
  tags = {
    Name = "private-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = data.aws_vpc.default.id
  ipv6_cidr_block   = "2600:1f18:7b3f:4221::/64"
  cidr_block        = "172.31.128.0/20"
  availability_zone = "${data.aws_region.current.name}b"
  tags = {
    Name = "private-b"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id            = data.aws_vpc.default.id
  ipv6_cidr_block   = "2600:1f18:7b3f:4222::/64"
  cidr_block        = "172.31.144.0/20"
  availability_zone = "${data.aws_region.current.name}c"
  tags = {
    Name = "private-c"
  }
}
