# ArgoCD on Google Kubernetes Engine

*This repository contains Terraform code to create a GKE cluster to test GitOps deployment.*

This Terraform configuration will perform following actions:
* Create a GKE cluster
* Install Argo CD on it
* Create an application on it with auto-sync enabled

## Pre-Requsites
* To use this repository, ensure you have created a GCP Workload Identity using [this repository](https://github.com/devops-sathsara/gcp-workload-identity/tree/main) and store the output to [GitHub action secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) named `WORKLOAD_IDENTITY_PROVIDER` (terraform output name `google_iam_workload_identity_pool_provider_name`) and `SERVICE_ACCOUNT` (terraform output name `google_service_account_email`).
* Update the `env_project_id` and `region` with appropriate values in [inputs.hcl](https://github.com/devops-sathsara/gitops-infra/blob/main/environments/inputs.hcl) file
* Update the terraform backend configs in [terragrunt.hcl](https://github.com/devops-sathsara/gitops-infra/blob/main/environments/terragrunt.hcl) file 
