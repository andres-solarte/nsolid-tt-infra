module "bootstrap" {
  source = "../../modules/bootstrap"

  organization_name = var.organization_name
  project_name      = var.project_name
  environment_name  = var.environment_name
  gh_organization   = "andres-solarte"
  gh_repository     = "nsolid-tt-infra"
}

resource "aws_iam_role_policy_attachment" "cicd_attach" {
  role       = module.bootstrap.cicd_role_name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
