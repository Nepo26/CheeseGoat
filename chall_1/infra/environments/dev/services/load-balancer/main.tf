locals {
  # TODO Get bucket name from global or another definition
  log_bucket = "my-alb-logs"

  # TODO Define global tags
  tags       = {}
}


module "alb" {
  source = "terraform-aws-modules/alb/aws"
  # TODO Define better ALB naminbg
  name    = "my-alb"
  vpc_id  = var.vpc_id
  subnets = var.public_subnet_ids

  # Security Group
  security_group_ingress_rules = {
    # TODO Improve ingress rules
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  # TODO Improve egress rules
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "10.0.0.0/16"
    }
  }

  access_logs = {
    bucket = local.log_bucket
  }

  listeners = {
    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }


    }
  }

  # TODO Consider passing this target to the ec2 itself or another middle module
  target_groups = {
    ex-instance = {
      name_prefix = "h1"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"
      target_id   = var.target_id
    }
  }

  tags = local.tags
}