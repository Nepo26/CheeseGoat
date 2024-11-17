variable "allowed_repos_branches" {
  description = "Repos and branches that will be able to assume the IAM role"
  type = list(object({
    org = string
    repo = string
    branch = string
  }))
  default = []
}
