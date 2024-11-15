# Configure the AWS Provider


# Define the common modules
generate "versions" {
  path="versions_override.tf"
  if_exists="overwrite_terragrunt"
  contents=<<EOF
      terraform {
        required_providers {
          aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
          }
        }
      }
    EOF
}


# Define AWS configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}
