
# # Kubernetes provider
# # The Terraform Kubernetes Provider configuration below is used as a learning reference only. 
# # It references the variables and resources provisioned in this file. 
# # We recommend you put this in another file -- so you can have a more modular configuration.
# # https://learn.hashicorp.com/terraform/kubernetes/provision-gke-cluster#optional-configure-terraform-kubernetes-provider
# # To learn how to schedule deployments and services using the provider, go here: https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider.

data "google_client_config" "current" {}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}

resource "kubernetes_namespace" "flux_hr_namespace" {
  metadata {
    name = "flux-hr"
  }
}