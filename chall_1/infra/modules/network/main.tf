terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}
data "aws_availability_zones" "available" {}


locals {
  azs = slice(data.aws_availability_zones.available.names, 0, var.n_public_subnets)

  total_private_subnets = max((var.n_public_subnets * var.qnt_private_per_public_subnet),2)

  total_of_subnets =  ceil((local.total_private_subnets+var.n_public_subnets))


  required_bits = ceil(log(local.total_of_subnets,2))
  all_subnets = [for i in range(local.total_of_subnets):
   cidrsubnet(var.cidr, local.required_bits, i )
  ]

  public_subnets = slice(local.all_subnets, 0, var.n_public_subnets)
  private_subnets = slice(local.all_subnets,var.n_public_subnets, length(local.all_subnets))

}


resource "null_resource" "guarantee_enough_availability_zones" {
  lifecycle {
    precondition {
      condition     = length(data.aws_availability_zones.available.names) >= var.n_public_subnets
      error_message = "Not enough availability zones to accommodate the required public subnets."
    }
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.15.0"

  name = var.name
  cidr = var.cidr

  azs = local.azs
  public_subnets = local.public_subnets
  private_subnets = local.private_subnets

  enable_nat_gateway = true



  tags=var.tags
}

