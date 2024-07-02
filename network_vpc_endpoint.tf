# network_vpc_endpoint.tf

resource "aws_vpc_endpoint" "s3" {
  service_name        = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_id              = data.aws_vpc.default.id
  subnet_ids          = data.aws_subnets.default.ids
  route_table_ids = [
    data.aws_route_table.main.id
  ]
}
