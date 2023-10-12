
resource "aws_s3_object" "teste" {
  bucket  = "iac.francl.in"
  key     = "teste.txt"
  content = "teste"
}
