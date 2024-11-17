module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance-${var.environment}"

  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  monitoring             = true
  subnet_id              = var.subnet_id

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}
