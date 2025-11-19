module "network" {
  source = "../../modules/network"

  organization_name      = var.organization_name
  project_name           = var.project_name
  environment_name       = var.environment_name
  vpc_cidr               = "10.20.0.0/16"
  vpc_az_count           = 3
  vpc_single_nat_gateway = true
  tags                   = local.tags
}
