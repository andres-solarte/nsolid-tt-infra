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

variable "kms_master_key_arn" {
  description = "The ARN of the KMS master key"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
}

variable "ecr_repository_read_write_access_arns" {
  description = "The ARNs of the accounts that have read/write access to the ECR repository"
  type        = list(string)
  default     = []
}

variable "managed_node_group" {
  type = object({
    name           = string
    capacity_type  = string
    instance_types = list(string)
    ami_type       = string
    desired_size   = number
    min_size       = number
    max_size       = number
    disk_size      = number
    labels         = map(string)
    tags           = map(string)
  })
}
