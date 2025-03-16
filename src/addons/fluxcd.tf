resource "helm_release" "fluxcd" {
  name       = "fluxcd"
  repository = "https://fluxcd-community.github.io/helm-charts"
  chart      = "flux2"
  namespace  = "flux-system"
  create_namespace = true

  values = [
    <<EOF
    gitRepository:
      enabled: true
      url: "ssh://git@github.com/devops-sathsara/gitops-manifests.git"
      secretRef: flux-system
    EOF
  ]
}
