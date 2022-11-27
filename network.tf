# DATA

data "aws_availability_zones" "available" {
  state = "available"
}


# VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>3.0"

  name           = "ec2-rds-terraform"
  cidr           = var.vpc_cidr_range
  azs            = slice(data.aws_availability_zones.available.names, 0, var.vpc_subnet_count)
  public_subnets = [for subnet in range(var.vpc_subnet_count) : cidrsubnet(var.vpc_cidr_range, 4, subnet)]

  enable_nat_gateway      = false
  enable_dns_hostnames    = var.enable_dns_hostnames
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = local.common_tags
}

# Security Group Inernal Web server
resource "aws_security_group" "internal-web-sg" {
  name   = "${local.name_prefix}-internal-web-sg"
  vpc_id = module.vpc.vpc_id

  # HTTP access from VPC
  ingress {
    from_port   = 433
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_range]
  }

   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_range]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}
# Security Group External Web server
resource "aws_security_group" "external-web-sg" {
  name   = "${local.name_prefix}-external-web-sg"
  vpc_id = module.vpc.vpc_id

  # HTTP access from VPC
  ingress {
    from_port   = 433
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_range]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}
# Security Group RDS instance