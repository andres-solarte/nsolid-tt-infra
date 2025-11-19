output "kms_master_key_arn" {
  value = module.kms.key_arn
}

output "kms_master_key_id" {
  value = module.kms.key_id
}

output "cicd_role_arn" {
  value = aws_iam_role.cicd.arn
}

output "cicd_role_name" {
  value = aws_iam_role.cicd.name
}