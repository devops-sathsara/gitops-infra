remote_state {
  backend = "gcs"

  config = {
    bucket      = "gitops-tf-state-bucket-${local.env}"
    prefix      = "tfstate"
    project     = "citric-shine-378115"
    location    = "us-east4"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}