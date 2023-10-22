
locals {
  gh_repo_id_iac_datamesh_glue_job        = 705420472
  gh_repo_owner_iac_datamesh_glue_job     = "fssou"
  gh_repo_name_iac_datamesh_glue_job      = "iac-aws-datamesh-glue-job"
  gh_repo_full_name_iac_datamesh_glue_job = "fssou/iac-aws-datamesh-glue-job"
}

resource "aws_iam_role" "iac_datamesh_glue_job" {
  path                  = "/github/"
  name                  = "repo-${local.gh_repo_id_iac_datamesh_glue_job}"
  description           = "Papel para criacao de recursos do repositorio ${local.gh_repo_owner_iac_datamesh_glue_job}/${local.gh_repo_name_iac_datamesh_glue_job}"
  force_detach_policies = true
  max_session_duration  = 3600
  assume_role_policy    = module.policy_document_iac_datamesh_glue_job.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "iac_datamesh_glue_job_state_bucket" {
  role       = aws_iam_role.iac_datamesh.name
  policy_arn = aws_iam_policy.iac_state_bucket.arn
}

resource "aws_iam_role_policy_attachment" "iac_datamesh_glue_job" {
  role       = aws_iam_role.iac_datamesh_glue_job.name
  policy_arn = aws_iam_policy.iac_datamesh_glue_job.arn
}

module "policy_document_iac_datamesh_glue_job" {
  source        = "./modules/iam_commons"
  gh_repo_id    = local.gh_repo_id_iac_datamesh_glue_job
  gh_repo_owner = local.gh_repo_owner_iac_datamesh_glue_job
  gh_repo_name  = local.gh_repo_name_iac_datamesh_glue_job
}

resource "aws_iam_policy" "iac_datamesh_glue_job" {
  path        = "/github/"
  name        = "repo-${local.gh_repo_id_iac_datamesh_glue_job}"
  description = "Politicas para criacao de recursos do repositorio ${local.gh_repo_owner_iac_datamesh_glue_job}/${local.gh_repo_name_iac_datamesh_glue_job}"
  policy      = data.aws_iam_policy_document.iac_datamesh_glue_job.json
}

data "aws_iam_policy_document" "iac_datamesh_glue_job" {
  version   = "2012-10-17"
  policy_id = "repo-${local.gh_repo_id_iac_datamesh_glue_job}"
  statement {
    sid = "GlueIacDatameshGlueJobSecurityGroup"
    actions = [
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateSecurityGroup",
      "ec2:DeleteSecurityGroup",
      "ec2:DescribeSecurityGroups",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:DescribeVpcs",
      "ec2:DescribeSubnets",
    ]
    effect = "Allow"
    resources = [ 
      "*"
     ]
  }
  statement {
    sid = "GlueIacDatameshGlueJob"
    actions = [
      "glue:*"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
  statement {
    sid = "S3IacDatameshGlueJobAssets"
    actions = [
      "s3:*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::aws-glue-assets.data.francl.in/${local.gh_repo_full_name_iac_datamesh_glue_job}/*",
    ]
  }
  statement {
    sid = "S3IacDatameshGlueJob"
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
    sid = "S3IacDatameshGlueJobRead"
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
