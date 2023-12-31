
resource "aws_iam_policy" "iac_state_bucket" {
  path   = "/github/"
  name   = "iac-state-bucket"
  policy = data.aws_iam_policy_document.iac_state_bucket.json
}

data "aws_iam_policy_document" "iac_state_bucket" {
  version = "2012-10-17"
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketTagging",
      "s3:ListBucketVersions",
      "s3:DeleteObject",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${var.bucket_name_state}"
    ]
  }
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectAttributes",
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:GetObjectTagging",
      "s3:DeleteObjectTagging",
      "s3:PutObjectTagging",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${var.bucket_name_state}/*"
    ]
  }
}
