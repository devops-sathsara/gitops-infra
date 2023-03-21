
data "google_client_config" "current" { }

data "google_container_cluster" "current" {
  name     = "${var.project_id}-gke"
  location = var.region
  project  = var.project_id
}

