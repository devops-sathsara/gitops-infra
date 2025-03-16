terraform {
  required_version = ">= 1.1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.27.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 4.5.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.13"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }

  }
}

provider "google" {
  project = var.env_project_id
  region  = var.region
}

provider "kubernetes" {
  host                   = "https://${var.kubernetes_cluster_host}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

provider "kubectl" {
  host                   = "https://${var.kubernetes_cluster_host}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = "https://${var.kubernetes_cluster_host}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  }
}
