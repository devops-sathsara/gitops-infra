
# # Kubernetes provider
# # The Terraform Kubernetes Provider configuration below is used as a learning reference only. 
# # It references the variables and resources provisioned in this file. 
# # We recommend you put this in another file -- so you can have a more modular configuration.
# # https://learn.hashicorp.com/terraform/kubernetes/provision-gke-cluster#optional-configure-terraform-kubernetes-provider
# # To learn how to schedule deployments and services using the provider, go here: https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider.

data "google_client_config" "current" {
  depends_on = [google_container_cluster.primary]
}

data "google_container_cluster" "current" {
  name     = "${var.project_id}-gke"
  location = var.region
  project  = var.project_id

  depends_on = [google_container_cluster.primary]
}

data "flux_install" "main" {
  target_path = var.target_path
}

data "kubectl_file_documents" "install" {
  content = data.flux_install.main.content
}

resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = "flux-system"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }

  depends_on = [google_container_cluster.primary]
}

resource "kubectl_manifest" "install" {
  for_each  = data.kubectl_file_documents.install.manifests
  yaml_body = each.value

  depends_on = [google_container_cluster.primary]
}
