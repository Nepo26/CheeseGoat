include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    private_subnet_ids = [
      "MOCK_PRIVATE_SUBNET_1_ID",
      "MOCK_PRIVATE_SUBNET_2_ID"
    ]
  }
}

inputs = {
  subnet_id = dependency.vpc.outputs.private_subnet_ids[0]
  environment = "dev"
}

