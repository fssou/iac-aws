
locals {
  gh_repo_id        = 704373873
  gh_repo_owner     = "fssou"
  gh_repo_name      = "iac-aws-datamesh"
  bucket_name_state = var.bucket_name_state
}

resource "aws_iam_role" "iac_datamesh" {
  path                  = "/github/"
  name                  = "repo-${local.gh_repo_id}"
  description           = "Papel para criacao de recursos do repositorio ${local.gh_repo_owner}/${local.gh_repo_name}"
  force_detach_policies = true
  max_session_duration  = 3600
  assume_role_policy    = module.policy_document_iac_datamesh.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "iac_datamesh_bucket_state" {
  role       = aws_iam_role.iac_datamesh.name
  policy_arn = aws_iam_policy.iac_state_bucket.arn
}

resource "aws_iam_role_policy_attachment" "iac_datamesh" {
  role       = aws_iam_role.iac_datamesh.name
  policy_arn = aws_iam_policy.iac_datamesh.arn
}

module "policy_document_iac_datamesh" {
  source        = "./modules/iam_commons"
  gh_repo_id    = local.gh_repo_id
  gh_repo_owner = local.gh_repo_owner
  gh_repo_name  = local.gh_repo_name
}

resource "aws_iam_policy" "iac_datamesh" {
  path        = "/github/"
  name        = "repo-${local.gh_repo_id}"
  description = "Politicas para criacao de recursos do repositorio ${local.gh_repo_owner}/${local.gh_repo_name}"
  policy      = data.aws_iam_policy_document.iac_datamesh.json
}

data "aws_iam_policy_document" "iac_datamesh" {
  version   = "2012-10-17"
  policy_id = "repo-${local.gh_repo_id}"
  statement {
    sid = "GlueIacDatamesh"
    actions = [
      "glue:*"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
  statement {
    sid = "S3IacDatamesh"
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:DeleteBucketPolicy",
      "s3:PutAccessPointPolicy",
      "s3:PutAccessPointPublicAccessBlock",
      "s3:PutAccountPublicAccessBlock",
      "s3:PutBucketAcl",
      "s3:PutBucketCORS",
      "s3:PutBucketOwnershipControls",
      "s3:PutBucketPolicy",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutBucketTagging",
      "s3:PutBucketVersioning",
      "s3:PutEncryptionConfiguration",
      "s3:PutIntelligentTieringConfiguration",
      "s3:PutLifecycleConfiguration",
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
  statement {
    sid = "S3IacDatameshRead"
    actions = [
      "s3:GetAccelerateConfiguration",
      "s3:GetAccessPoint",
      "s3:GetAccessPointConfigurationForObjectLambda",
      "s3:GetAccessPointForObjectLambda",
      "s3:GetAccessPointPolicy",
      "s3:GetAccessPointPolicyForObjectLambda",
      "s3:GetAccessPointPolicyStatus",
      "s3:GetAccessPointPolicyStatusForObjectLambda",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetAnalyticsConfiguration",
      "s3:GetBucketAcl",
      "s3:GetBucketCORS",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "s3:GetBucketNotification",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetBucketOwnershipControls",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetBucketWebsite",
      "s3:GetEncryptionConfiguration",
      "s3:GetIntelligentTieringConfiguration",
      "s3:GetInventoryConfiguration",
      "s3:GetJobTagging",
      "s3:GetLifecycleConfiguration",
      "s3:GetMetricsConfiguration",
      "s3:GetMultiRegionAccessPoint",
      "s3:GetMultiRegionAccessPointPolicy",
      "s3:GetMultiRegionAccessPointPolicyStatus",
      "s3:GetMultiRegionAccessPointRoutes",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectAttributes",
      "s3:GetObjectLegalHold",
      "s3:GetObjectRetention",
      "s3:GetObjectTagging",
      "s3:GetObjectTorrent",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionAttributes",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionTagging",
      "s3:GetObjectVersionTorrent",
      "s3:GetReplicationConfiguration",
      "s3:GetStorageLensConfiguration",
      "s3:GetStorageLensConfigurationTagging",
      "s3:GetStorageLensDashboard",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListBucketVersions",
      "s3:ListMultipartUploadParts",
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}
