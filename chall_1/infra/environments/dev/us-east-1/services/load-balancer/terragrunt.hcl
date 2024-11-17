include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    vpc_id = "MOCK_VPC_ID"
    public_subnet_ids = [
      "MOCK_SUBNET_1_ID",
      "MOCK_SUBNET_2_ID"
      ]
  }
}

dependency "ec2" {
  config_path = "../ec2"
  mock_outputs = {
    ec2_id = "MOCK_EC2_ID"
  }
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  public_subnet_ids  = dependency.vpc.outputs.public_subnet_ids
  target_id=dependency.ec2.outputs.ec2_id
}

