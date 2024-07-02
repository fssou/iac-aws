# data.tf

data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  default = true
}

data "aws_region" "current" {
  name = var.region
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