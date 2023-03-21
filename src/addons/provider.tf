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
  project = var.project_id
  region  = var.region
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.current.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64encode(data.google_container_cluster.current.master_auth.0.cluster_ca_certificate)
}

provider "kubectl" {
  host                   = "https://${data.google_container_cluster.current.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64encode(data.google_container_cluster.current.master_auth.0.cluster_ca_certificate)
  load_config_file       = false
}

provider "flux" {}