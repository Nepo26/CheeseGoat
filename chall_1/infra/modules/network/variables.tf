variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to the AWS resources, for organization and cost tracking purposes."
}

variable "name" {
  type        = string
  description = "The name of the VPC, used for resource naming and identification."
}


variable "n_public_subnets" {
  description = "Number of public subnets"
  type        = number
  validation {
    condition     = var.n_public_subnets > 0
    error_message = "The number of public subnets must be greater than zero."
  }
}

variable "qnt_private_per_public_subnet" {
  description = "Number of private subnets per public subnet"
  type        = number
  validation {
    condition     = var.qnt_private_per_public_subnet > 0
    error_message = "The number of private subnets must be greater than zero."
  }
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  validation {
    condition     = can(cidrsubnet(var.cidr, 4, 0))
    error_message = "The provided CIDR block is too small to accommodate both public and private subnets. Use a larger CIDR range."
  }
}
