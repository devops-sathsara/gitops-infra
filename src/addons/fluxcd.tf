resource "helm_release" "fluxcd" {
  name       = "fluxcd"
  repository = "https://fluxcd-community.github.io/helm-charts"
  chart      = "flux2"
  namespace  = "flux-system"
  version    = "2.12.0"
  create_namespace = true

  values = [
    <<EOF
    installCRDs: true
    EOF
  ]
}
