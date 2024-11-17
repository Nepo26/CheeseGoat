locals {
  environment = "management"
  account_name = "management"

  aws_account_id = "${get_env("MGMT_ACCOUNT_ID","")}"
}
