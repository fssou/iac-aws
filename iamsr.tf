
data "aws_iam_policy_document" "assume_role_teste" {
  version = "2012-10-17"
  statement {
    sid = "IamsrAssumeRoleTeste"
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "policiy_teste" {
  version = "2012-10-17"
  statement {
    actions = ["ec2:Describe*"]
    effect = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role" "iamsr_teste" {
  path = "/iamsr"
  name = "teste"
  assume_role_policy = data.aws_iam_policy_document.assume_role_teste.json
}

resource "aws_iam_policy" "iamsr_teste" {
  path = "/iamsr"
  name = "teste"
  policy = data.aws_iam_policy_document.policiy_teste.json
}

resource "aws_iam_role_policy_attachment" "iamsr_teste" {
  role = aws_iam_role.iamsr_teste.name
  policy_arn = aws_iam_policy.iamsr_teste.arn
}
