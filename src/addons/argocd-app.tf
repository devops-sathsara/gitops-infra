data "kubectl_file_documents" "argocd-app" {
    content = file("./manifests/argocd/argocd-app.yaml")
}

resource "kubectl_manifest" "argocd-app" {
    count               = length(data.kubectl_file_documents.argocd-app.documents)
    yaml_body           = element(data.kubectl_file_documents.argocd-app.documents, count.index)
    override_namespace  = "argocd"
    depends_on          = [kubectl_manifest.argocd_install]
}

