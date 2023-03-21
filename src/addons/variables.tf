variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region name"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "GKE Cluster certificate"
  type        = string
}