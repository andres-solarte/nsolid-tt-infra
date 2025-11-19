locals {
  tags = merge(var.tags, {
    module = "network"
  })

  azs             = slice(data.aws_availability_zones.available.names, 0, var.vpc_az_count)
  private_subnets = [for i in range(var.vpc_az_count) : cidrsubnet(var.vpc_cidr, 8, i)]
  public_subnets  = [for i in range(var.vpc_az_count) : cidrsubnet(var.vpc_cidr, 8, i + var.vpc_az_count)]
}
