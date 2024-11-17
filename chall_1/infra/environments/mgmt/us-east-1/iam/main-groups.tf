module "iam_group_sre" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"

  name = "sre"

  assumable_roles = [module.iam_github_oidc_role.arn]

  group_users = [
    module.iam_user_gordon.iam_user_name
  ]
}
