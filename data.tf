# data.tf

data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  default = true
}

data "aws_region" "current" {
  name = var.region
}

data "aws_availability_zone" "current" {

  filter {
    name   = "region-name"
    values = [data.aws_region.current.name]
  }
}

data "aws_availability_zones" "current" {
  filter {
    name   = "region-name"
    values = [data.aws_region.current.name]
  }
}

data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "availability-zone"
    values = [data.aws_availability_zone.current.name]
  }
  filter {
    name = "default-for-az"
    values = [
      "true"
    ]
  }
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [
      data.aws_vpc.default.id
    ]
  }
  filter {
    name = "default-for-az"
    values = [
      "true"
    ]
  }
}

data "aws_route_table" "main" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}