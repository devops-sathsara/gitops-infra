variable "env_project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region name"
  type        = string
}

variable "kubernetes_cluster_host" {
  description = "GKE Cluster endpoint"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "GKE Cluster certificate"
  type        = string
}

variable "target_path" {
  type        = string
  default     = "staging-cluster"
  description = "flux sync target path"
}

variable "github_org" {
  type        = string
  default     = "devops-sathsara"
  description = "github org to use with flux"
}

variable "github_repository" {
  type        = string
  default     = "gitops-manifests"
  description = "github repository to use with flux"
}