variable "project_name" {
  description = "Project tag value"
  type        = string
  default     = "final-project"
}

variable "environment" {
  description = "Environment tag value"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.20.0.0/16"
}

variable "azs" {
  description = "AZs for public subnets"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "endpoint_private_access" {
  description = "Enable private endpoint access"
  type        = bool
  default     = false
}

variable "endpoint_public_access" {
  description = "Enable public endpoint access"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "Allowed CIDRs for public API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_cluster_logging" {
  description = "Enable EKS control plane logs"
  type        = bool
  default     = true
}

variable "cluster_log_types" {
  description = "Control plane log types"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "node_instance_types" {
  description = "EKS managed node group instance types"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "node_ami_type" {
  description = "Node AMI type"
  type        = string
  default     = "AL2_x86_64"
}

variable "node_disk_size" {
  description = "Root volume size (GiB)"
  type        = number
  default     = 30
}

variable "node_desired_size" {
  description = "Desired node count"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum node count"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum node count"
  type        = number
  default     = 4
}

variable "oidc_thumbprint" {
  description = "OIDC provider root CA thumbprint"
  type        = string
  default     = "9e99a48a9960b14926bb7f3b02e22da0afd40f3f"
}

variable "enable_aws_load_balancer_controller" {
  description = "Install AWS Load Balancer Controller"
  type        = bool
  default     = true
}

variable "aws_load_balancer_controller_chart_version" {
  description = "AWS Load Balancer Controller Helm chart version"
  type        = string
  default     = "1.11.0"
}

variable "enable_external_dns" {
  description = "Install ExternalDNS"
  type        = bool
  default     = true
}

variable "external_dns_chart_version" {
  description = "ExternalDNS Helm chart version"
  type        = string
  default     = "1.15.0"
}

variable "external_dns_domain_filters" {
  description = "Route53 domain filters for ExternalDNS"
  type        = list(string)
  default     = []
}

variable "external_dns_txt_owner_id" {
  description = "ExternalDNS txtOwnerId (defaults to cluster_name if null)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
