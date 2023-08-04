# AWS EKS Playground
Playground for EKS AWS, written using terraform to learn how to deploy the service

Objectives:
 - [x] Create an EKS cluster (controll plane)
 - [x] Privison a managed node group (data plane)
 - [ ] Bootstrap the EKS cluster with ArgoCD
 - [ ] Ensure IAM user can view Kube resources, including adons in the UI. <- Come back to this as you need a gitops approach to automate the deployment of this.
 - [ ] Get the metric server running
 - [ ] Deploy Nginx to the cluster
 - [ ] Implement HPA for the Nginx deployment
 - [ ] Expose Nginx via Ingres/Service that uses AWS ALB