variable "vpc_id" {
  description = "The VPC ID where the ALB is created."
  type        = string
}

variable "public_subnet_ids" {
  description = "Subnet IDs for load balancer"
  type        = list(string)
}

variable "environment" {
}

variable "target_id" {
  description = "Target ALB target ID"
  type        = string
}