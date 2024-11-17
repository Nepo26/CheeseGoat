module "iam_user_gordon" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name          = "gordon"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

locals {
  iam_users = [
    module.iam_user_gordon
  ]
}
