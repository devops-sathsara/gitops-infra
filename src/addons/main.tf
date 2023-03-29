
data "google_client_config" "current" { }

data "google_container_cluster" "current" {
  name     = "${var.env_project_id}-gke"
  location = var.region
  project  = var.env_project_id
}

