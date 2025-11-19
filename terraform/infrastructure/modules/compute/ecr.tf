module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "3.1.0"

  repository_name                   = "${var.organization_name}-${var.project_name}-${var.environment_name}"
  repository_read_write_access_arns = var.ecr_repository_read_write_access_arns

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 5 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["latest"],
          countType     = "imageCountMoreThan",
          countNumber   = 5
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}
