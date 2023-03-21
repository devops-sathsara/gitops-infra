data "kubectl_file_documents" "argocd_namespace" {
    content = file("./manifests/argocd/namespace.yaml")
} 

data "kubectl_file_documents" "argocd_install" {
    content = file("./manifests/argocd/install.yaml")
}

resource "kubectl_manifest" "argocd_namespace" {
    count               = length(data.kubectl_file_documents.argocd_namespace.documents)
    yaml_body           = element(data.kubectl_file_documents.argocd_namespace.documents, count.index)
    override_namespace  = "argocd"
}

resource "kubectl_manifest" "argocd_install" {
    count               = length(data.kubectl_file_documents.argocd_install.documents)
    yaml_body           = element(data.kubectl_file_documents.argocd_install.documents, count.index)
    override_namespace  = "argocd"
    depends_on          = [kubectl_manifest.argocd_namespace]
}