module "terraform_state_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.7.1"

  name                        = "tf-state"
  namespace                   = var.organization_name
  stage                       = var.project_name
  deletion_protection_enabled = true
  environment                 = var.environment_name
}
