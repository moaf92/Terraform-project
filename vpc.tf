module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = var.VPC_NAME
  cidr            = var.VPC_CIDR
  azs             = [var.Zone1, var.Zone2, var.Zone3]
  private_subnets = [var.prisub1CIDR, var.pivsub2CIDR, var.pivsub3CIDR]
  public_subnets  = [var.pubsub1CIDR, var.pubsub2CIDR, var.pubsub3CIDR]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = "prod"
  }
  vpc_tags = {
    Name = var.VPC_NAME
  }
}