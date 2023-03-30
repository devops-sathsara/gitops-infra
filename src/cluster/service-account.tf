resource "google_service_account" "artifact_registry" {
  account_id   = "artifact-registry-gke-sa"
  display_name = "Artifact registry access from GKE cluster"
}

resource "google_service_account_key" "artifact_registry" {
  service_account_id = google_service_account.artifact_registry.name
}