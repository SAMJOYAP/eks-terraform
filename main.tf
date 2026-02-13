locals {
  name = var.cluster_name

  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    },
    var.tags
  )

  external_dns_txt_owner_id = var.external_dns_txt_owner_id != null ? var.external_dns_txt_owner_id : var.cluster_name
}

module "network" {
  source = "./modules/network"

  cluster_name        = local.name
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  public_subnet_cidrs = var.public_subnet_cidrs
  tags                = local.common_tags
}

module "eks" {
  source = "./modules/eks"

  cluster_name            = local.name
  kubernetes_version      = var.kubernetes_version
  subnet_ids              = module.network.public_subnet_ids
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  public_access_cidrs     = var.public_access_cidrs
  enable_cluster_logging  = var.enable_cluster_logging
  cluster_log_types       = var.cluster_log_types
  node_instance_types     = var.node_instance_types
  node_capacity_type      = var.node_capacity_type
  node_ami_type           = var.node_ami_type
  node_disk_size          = var.node_disk_size
  node_desired_size       = var.node_desired_size
  node_min_size           = var.node_min_size
  node_max_size           = var.node_max_size
  oidc_thumbprint         = var.oidc_thumbprint
  tags                    = local.common_tags
}

# Helm/Kubernetes provider bootstrapping after EKS exists.
data "aws_eks_cluster" "this" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "this" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

module "addons" {
  source = "./modules/addons"

  cluster_name                               = module.eks.cluster_name
  region                                     = var.region
  vpc_id                                     = module.network.vpc_id
  oidc_provider_arn                          = module.eks.oidc_provider_arn
  oidc_provider_hostpath                     = module.eks.oidc_provider_hostpath
  enable_aws_load_balancer_controller        = var.enable_aws_load_balancer_controller
  aws_load_balancer_controller_chart_version = var.aws_load_balancer_controller_chart_version
  enable_external_dns                        = var.enable_external_dns
  external_dns_chart_version                 = var.external_dns_chart_version
  external_dns_domain_filters                = var.external_dns_domain_filters
  external_dns_txt_owner_id                  = local.external_dns_txt_owner_id
  tags                                       = local.common_tags

  depends_on = [module.eks]
}
