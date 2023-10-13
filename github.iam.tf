
locals {
  gh_repo_id    = 704373873
  gh_repo_owner = "fssou"
  gh_repo_name  = "iac-aws-datamesh"
  state_bucket  = "iac.francl.in"
}

resource "aws_iam_role" "iac_datamesh" {
  path = "/github/"
  name = "repo-${ local.gh_repo_id }"
  description = "Papel para criacao de recursos do repositorio ${ local.gh_repo_owner }/${ local.gh_repo_name }"
  force_detach_policies =  true
  max_session_duration = 3600
  assume_role_policy = module.policy_document_iac_datamesh.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "iac_datamesh_bucket_state" {
  role = aws_iam_role.iac_datamesh.name
  policy_arn = aws_iam_policy.iac_state_bucket.arn
}

module "policy_document_iac_datamesh" {
  source        = "./modules/common_iam"
  gh_repo_id    = local.gh_repo_id
  gh_repo_owner = local.gh_repo_owner
}


resource "aws_iam_policy" "iac_datamesh" {
  path   = "/github/"
  name   = "repo-${ local.gh_repo_id }"
  policy = data.aws_iam_policy_document.iac_datamesh.json
}

data "aws_iam_policy_document" "iac_datamesh" {
  version  = "2012-10-17"
  policy_id = "repo-${ local.gh_repo_id }"
  statement {
    actions = [
      "s3:*"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}
