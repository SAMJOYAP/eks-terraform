variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider_hostpath" {
  type = string
}

variable "enable_aws_load_balancer_controller" {
  type = bool
}

variable "aws_load_balancer_controller_chart_version" {
  type = string
}

variable "enable_external_dns" {
  type = bool
}

variable "external_dns_chart_version" {
  type = string
}

variable "external_dns_domain_filters" {
  type = list(string)
}

variable "external_dns_txt_owner_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
