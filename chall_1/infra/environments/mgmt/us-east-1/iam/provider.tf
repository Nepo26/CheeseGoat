# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
provider "aws" {
  region = "us-east-1"

  # To allow only this AWS Account ID to operate this template.
  # Prevent you from mistakenly using an incorrect one
  # (and potentially end up destroying a live environment).
  allowed_account_ids = ["766722845693"]
}
