terraform {
  source = "git::https://github.com/devops-sathsara/gitops-infra.git//src?ref=main"
}

# Find root terragrunt.hcl and inherit its configurations
include {
  path = find_in_parent_folders()
}

inputs = {
  environment   = "dev"
  project_id    = "sathsara-dev"
}