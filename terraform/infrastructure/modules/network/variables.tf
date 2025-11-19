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

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_az_count" {
  description = "The number of availability zones for the VPC"
  type        = number
  default     = 3
}

variable "vpc_single_nat_gateway" {
  description = "Whether to use a single NAT gateway for the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "The tags for the VPC"
  type        = map(string)
  default     = {}
}
