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

data "kubectl_file_documents" "flux_install" {
  content = data.flux_install.main.content
}

resource "kubectl_manifest" "flux_install" {
  for_each              = data.kubectl_file_documents.flux_install.manifests
  yaml_body             = each.value
  override_namespace    = "flux-system"
  depends_on            = [kubernetes_namespace.flux_system]
}
