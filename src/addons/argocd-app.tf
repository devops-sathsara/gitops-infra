data "kubectl_file_documents" "my-nginx-app" {
    content = file("./manifests/argocd-apps/nginx.yaml")
}

resource "kubectl_manifest" "my-nginx-app" {
    count               = length(data.kubectl_file_documents.my-nginx-app.documents)
    yaml_body           = element(data.kubectl_file_documents.my-nginx-app.documents, count.index)
    override_namespace  = "argocd"
    depends_on          = [kubectl_manifest.argocd_install]
}


data "kubectl_file_documents" "k8s-addons" {
    content = file("./manifests/argocd-apps/addons.yaml")
}

resource "kubectl_manifest" "k8s-addons" {
    count               = length(data.kubectl_file_documents.k8s-addons.documents)
    yaml_body           = element(data.kubectl_file_documents.k8s-addons.documents, count.index)
    override_namespace  = "argocd"
    depends_on          = [kubectl_manifest.argocd_install]
}