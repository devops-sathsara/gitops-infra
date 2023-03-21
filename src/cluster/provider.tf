terraform {
  required_version = ">= 1.1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.27.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
