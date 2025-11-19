variable "organization_name" {
  description = "The name of the organization"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment_name" {
  description = "The name of the environment"
  type        = string
}

variable "gh_organization" {
  description = "The name of the GitHub organization"
  type        = string
}

variable "gh_repository" {
  description = "The name of the GitHub repository"
  type        = string
}

variable "cicd_role_trust_policy_additional_statements" {
  description = "Additional statements to add to the trust policy"
  type        = list(any)
  default     = []
}
