# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "cheese-goat-terraform-state-management-us-east-1"
    dynamodb_table = "tf-state-lock"
    encrypt        = true
    key            = "environments/mgmt/us-east-1/iam/state.tfstate"
    region         = "us-east-1"
  }
}
