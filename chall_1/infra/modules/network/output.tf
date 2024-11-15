output "validate_azs" {
  value       = length(local.azs )>= var.n_public_subnets
  description = "Check if the number of AZs is sufficient for the public subnets."
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.available
}

output "azs" {
  value = local.azs

}

output "total_of_subnets" {
  value = local.total_of_subnets
}

output "required_bits" {
  value = local.required_bits
}

output "vpc" {
  value = module.vpc
}
output "cidr" {
  value = var.cidr
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}