module "compute" {
  source = "../../modules/compute"

  organization_name = var.organization_name
  project_name      = var.project_name
  environment_name  = var.environment_name

  kms_master_key_arn = module.bootstrap.kms_master_key_arn
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids

  ecr_repository_read_write_access_arns = [module.bootstrap.cicd_role_arn]

  managed_node_group = {
    name           = "general"
    capacity_type  = "ON_DEMAND"
    instance_types = ["t3.medium"]
    ami_type       = "AL2023_x86_64_STANDARD"
    desired_size   = 1
    min_size       = 1
    max_size       = 2
    disk_size      = 20
    labels = {
      workload = "general"
    }
    tags = merge(local.tags, {
      "nodesource:node-group" = "main"
    })
  }
}
