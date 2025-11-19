locals {
  tags = {
    organization = var.organization_name
    project      = var.project_name
    environment  = var.environment_name
  }

  reserved_sso_administrator_access_role_name = one([
    for role_name in data.aws_iam_roles.sso_roles.names : role_name
    if startswith(role_name, "AWSReservedSSO_AdministratorAccess_")
  ])
}