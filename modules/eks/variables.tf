variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "endpoint_private_access" {
  type = bool
}

variable "endpoint_public_access" {
  type = bool
}

variable "public_access_cidrs" {
  type = list(string)
}

variable "enable_cluster_logging" {
  type = bool
}

variable "cluster_log_types" {
  type = list(string)
}

variable "node_instance_types" {
  type = list(string)
}

variable "node_capacity_type" {
  type = string
}

variable "node_ami_type" {
  type = string
}

variable "node_disk_size" {
  type = number
}

variable "node_desired_size" {
  type = number
}

variable "node_min_size" {
  type = number
}

variable "node_max_size" {
  type = number
}

variable "oidc_thumbprint" {
  type = string
}

variable "tags" {
  type = map(string)
}
