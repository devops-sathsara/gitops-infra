variable "env_project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region name"
  type        = string
}

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}