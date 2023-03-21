data "kubectl_file_documents" "my-nginx-app" {
    content = file("./manifests/argocd/app-nginx.yaml")
}

resource "kubectl_manifest" "my-nginx-app" {
    count               = length(data.kubectl_file_documents.my-nginx-app.documents)
    yaml_body           = element(data.kubectl_file_documents.my-nginx-app.documents, count.index)
    override_namespace  = "argocd"
    depends_on          = [kubectl_manifest.argocd]
}