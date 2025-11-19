module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "${var.organization_name}-${var.project_name}-${var.environment_name}-eks"
  kubernetes_version = "1.34"

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnet_ids
  control_plane_subnet_ids = var.private_subnet_ids
  iam_role_use_name_prefix = false

  eks_managed_node_groups = {
    "${var.managed_node_group.name}" = {
      capacity_type  = var.managed_node_group.capacity_type
      instance_types = var.managed_node_group.instance_types
      ami_type       = var.managed_node_group.ami_type
      desired_size   = var.managed_node_group.desired_size
      min_size       = var.managed_node_group.min_size
      max_size       = var.managed_node_group.max_size
      disk_size      = var.managed_node_group.disk_size
      labels         = var.managed_node_group.labels
      tags           = var.managed_node_group.tags
    }
  }
}


module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.22.0"

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  eks_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
  }

  enable_aws_load_balancer_controller = true
  enable_metrics_server               = true
  enable_external_dns                 = true
}
