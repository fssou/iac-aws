
module "iam_repositories" {
    source = "./modules/iam_repositories"
    bucket_name_state = var.bucket_name_state
}
