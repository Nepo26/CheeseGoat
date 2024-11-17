locals {
  environment = "global"
  account_name = "global"

  aws_account_id = "${get_env("GLOBAL_ACCOUNT_ID","")}"
}
