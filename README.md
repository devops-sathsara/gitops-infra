# ArgoCD on Google Kubernetes Engine

*This repository contains Terraform code to create a GKE cluster to test GitOps deployment.*

This Terraform configuration will perform following actions:
* Create a GKE cluster
* Install Argo CD on it
* Create an application on it with auto-sync enabled