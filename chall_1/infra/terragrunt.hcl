locals {
  project_name = "${get_env("CG_PROJECT_NAME","cheese-goat")}"

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))


  # Extract the variables we need for easy access
  account_name = local.environment_vars.locals.account_name
  account_id = local.environment_vars.locals.aws_account_id
  environment = local.environment_vars.locals.environment

  aws_region = local.region_vars.locals.aws_region
}


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
  region = "${local.aws_region}"

  # To allow only this AWS Account ID to operate this template.
  # Prevent you from mistakenly using an incorrect one
  # (and potentially end up destroying a live environment).
  allowed_account_ids = ["${local.account_id}"]
}
EOF
}

# Configure Terragrunt to store tfstate files in an S3 bucket
# QUESTION Pretty great, but should we resort to terragrunt to manage state? Be careful with breaking changes.
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.project_name}-terraform-state-${local.account_name}-${local.aws_region}"
    key            = "${path_relative_to_include()}/state.tfstate"
    region         = local.aws_region
    dynamodb_table = "tf-state-lock"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.region_vars.locals,
  local.environment_vars.locals,
)
