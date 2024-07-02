# network_vpc_endpoint.tf

resource "aws_vpc_endpoint" "s3" {
  service_name        = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_id              = data.aws_vpc.default.id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids = [
    data.aws_security_group.default.id,
  ]
}
