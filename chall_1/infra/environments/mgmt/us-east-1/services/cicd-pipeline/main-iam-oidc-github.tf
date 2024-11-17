resource "aws_iam_openid_connect_provider" "github_actions" {
 url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [ data.tls_certificate.github.certificates[0].sha1_fingerprint ]
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
      type = "Federated"
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        for repo in var.allowed_repos_branches: "repo:${repo["org"]}/${repo["repo"]}:ref:refs/heads/${repo["branch"]}}"
      ]
    }

  }
}


