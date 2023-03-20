locals {
  dir_parsed = regex(".*/(?P<env>.*?)$", get_terragrunt_dir())
  env        = local.dir_parsed.env
}

remote_state {
  backend = "gcs"

  config = {
    bucket      = "gitops-tf-state-bucket-${local.env}"
    prefix      = "${path_relative_to_include()}/tfstate"
    project     = "citric-shine-378115"
    location    = "us-east4"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}