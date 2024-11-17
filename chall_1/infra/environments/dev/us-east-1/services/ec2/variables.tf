variable "environment" {
}

variable "subnet_id" {
  description = "Subnet identifier"
  type        = string
}

variable "ssh_key_name" {
  description = "SSH keypair name of EC2 instances"
  type        = string
  default = ""
}
