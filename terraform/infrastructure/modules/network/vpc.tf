module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.5.0"

  name            = "${var.organization_name}-${var.environment_name}"
  cidr            = var.vpc_cidr
  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = var.vpc_single_nat_gateway
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_flow_log                                 = true
  create_flow_log_cloudwatch_log_group            = true
  flow_log_cloudwatch_log_group_retention_in_days = 30
  create_flow_log_cloudwatch_iam_role             = true

  manage_default_security_group  = true
  default_security_group_name    = "${var.organization_name}-${var.environment_name}-default-sg"
  default_security_group_ingress = []
  default_security_group_egress  = []
}
