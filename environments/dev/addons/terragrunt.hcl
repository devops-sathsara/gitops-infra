# Find root terragrunt.hcl and inherit its configurations
include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/devops-sathsara/gitops-infra.git//src/addons?ref=main"
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("inputs.hcl"))
}

dependency "cluster" {
  config_path = "../cluster"
  mock_outputs = {
    database_id = "temporary-dummy-id"
  }
}
 
inputs = merge(
  local.common_vars.inputs,
  {
    database_id   = dependency.cluster.outputs.cluster_ca_certificate
  }
)

