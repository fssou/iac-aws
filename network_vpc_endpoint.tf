# network_vpc_endpoint.tf

resource "aws_vpc_endpoint" "s3" {
  service_name        = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_id              = data.aws_vpc.default.id
  route_table_ids = [
    aws_route_table.private_route_table.id,
    data.data.aws_route_table.main.id,
  ]
}
