
resource "aws_vpc_endpoint" "s3" {
  vpc_id = data.aws_vpc.default.id
  service_name = "com.amazonaws.us-east-1.s3"
}
