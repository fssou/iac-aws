# network_vpc_endpoint.tf

resource "aws_vpc_endpoint" "s3" {
  service_name        = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_id              = data.aws_vpc.default.id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  ip_address_type = "dualstack"
  dns_options {
    dns_record_ip_type = "dualstack"
    private_dns_only_for_inbound_resolver_endpoint = true
  }
  security_group_ids = [
    data.aws_security_group.default.id,
  ]
  subnet_ids = concat(
    [aws_subnet.private_a.id],
    [aws_subnet.private_b.id],
    [aws_subnet.private_c.id],
  )
}
