
# # Kubernetes provider
# # The Terraform Kubernetes Provider configuration below is used as a learning reference only. 
# # It references the variables and resources provisioned in this file. 
# # We recommend you put this in another file -- so you can have a more modular configuration.
# # https://learn.hashicorp.com/terraform/kubernetes/provision-gke-cluster#optional-configure-terraform-kubernetes-provider
# # To learn how to schedule deployments and services using the provider, go here: https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider.

data "google_client_config" "current" {}

data "google_container_cluster" "current" {
  name     = "${var.project_id}-gke"
  location = var.region
  project  = var.project_id
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.current.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.current.master_auth.0.cluster_ca_certificate)
}

resource "kubernetes_namespace" "flux_hr_namespace" {
  metadata {
    name = "flux-hr"
  }
}

data "template_file" "flux" {
  template = file("${path.module}/templates/flux.yaml")
  vars = {
    concurrency  = "16"
    loglevel     = "info"
    qps          = "300"
    burst        = "800"
    helm_version = "v0.17.1"
  }
}






provider "flux" {}

provider "kubectl" {}

resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = "flux-system"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

data "flux_install" "main" {
  target_path = var.target_path
}

data "kubectl_file_documents" "install" {
  content = data.flux_install.main.content
}

resource "kubectl_manifest" "test" {
    for_each  = data.kubectl_file_documents.install.manifests
    yaml_body = each.value
}
