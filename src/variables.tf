variable "environment" {
  description = "Environment name"
  type        = string

  validation {
    condition     = can(regex("^(dev|qa|prod)$", var.environment))
    error_message = "The environment name must be either dev,qa or prod."
  }
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}