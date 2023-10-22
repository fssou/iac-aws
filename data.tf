
data "aws_caller_identity" "main" {}

data "aws_vpc" "default" {
  default = true
}
