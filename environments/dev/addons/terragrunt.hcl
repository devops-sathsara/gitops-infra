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
    cluster_ca_certificate = "dummy_cluster_ca_certificate"
  }
}
 
inputs = merge(
  local.common_vars.inputs,
  {
    cluster_ca_certificate   = dependency.cluster.outputs.cluster_ca_certificate
  }
)
