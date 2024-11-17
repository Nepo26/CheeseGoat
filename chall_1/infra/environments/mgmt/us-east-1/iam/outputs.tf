output "iam_user_names" {
  value = [ for user in local.iam_users : user.iam_user_name ]
  description = "List of all created users"
}

output "github_oidc_role" {
  value = module.iam_github_oidc_role.arn
}
