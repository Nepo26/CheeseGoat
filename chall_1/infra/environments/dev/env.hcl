locals {
  environment = "dev"
  account_name = "dev"

  aws_account_id = "${get_env("DEV_ACCOUNT_ID","")}"
}
