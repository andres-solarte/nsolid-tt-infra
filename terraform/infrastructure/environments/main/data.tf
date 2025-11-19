data "aws_caller_identity" "current" {}

data "aws_iam_roles" "sso_roles" {
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}

data "aws_iam_role" "administrator_access" {
  name = local.reserved_sso_administrator_access_role_name
}