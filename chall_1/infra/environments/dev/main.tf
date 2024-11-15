/**
Create a simple vpc network with 'n' subnets with a specified cidr, will create a nat gateway if there are more than 1
private subnet.

-> ONLY 1 NAT GW
 */
# module "one_layer_network" {
#   source = "../../modules/network"
#
#   tags= {
#     Environment = "dev"
#     Team = "static-website"
#     Terraform = true
#   }
#
#   name="garfield"
#
#   qnt_private_per_public_subnet=1
#   n_public_subnets =1
#
#   cidr="10.0.0.0/24"
# }

data "aws_availability_zones" "available" {}

locals {
  name   = "garfield"
  team   = "CheeseGoat"
  env    = "dev"

  vpc_cidr = "10.0.0.0/24"
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)
  tags = {
    Application    = local.name
    GithubRepo = local.team
    Environment = local.env
    Team = local.team
    Terraform = true
  }

  network_acls = {
    default_inbound = [
      {
        rule_number = 900
        rule_action = "deny"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 100
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ],
    default_outbound = [
      {
        rule_number = 200
        rule_action = "allow"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ],
    public_inbound = [
      {
        rule_number = 300
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 400
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ],
    public_outbound = [

    ],
    private_inbound = [
      {
        rule_number = 300
        rule_action = "allow"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 400
        rule_action = "allow"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
    ],
    private_outbound = [

    ]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.15.0"

  name = local.name
  cidr = local.vpc_cidr

  azs = local.azs
  public_subnets = [for k,v in local.azs:  cidrsubnet(local.vpc_cidr, 2, k)]
  public_subnet_names = ["Load Balancer Subnet One", "Load Balancer Subnet Two"]

  private_subnets = [for k,v in local.azs:  cidrsubnet(local.vpc_cidr, 2, k+1)]
  # private_subnet_names = ["Private Subnet One", "Private Subnet Two"]
  manage_default_network_acl = true

  enable_dns_hostnames = true
  enable_dns_support = true

  enable_nat_gateway = true
  single_nat_gateway = true

  public_dedicated_network_acl = true

  # default_network_acl_ingress = local.network_acls["default_inbound"][0]
  # default_network_acl_egress = local.network_acls["default_outbound"][0]
  # manage_default_network_acl = true
  # private_inbound_acl_rules = concat(local.network_acls["default_inbound"], local.network_acls["private_inbound"])
  # private_outbound_acl_rules = concat(local.network_acls["default_outbound"], local.network_acls["private_outbound"])

  public_inbound_acl_rules = concat(local.network_acls["default_inbound"], local.network_acls["public_inbound"])
  public_outbound_acl_rules = concat(local.network_acls["default_outbound"], local.network_acls["public_outbound"])

  tags=local.tags
}

