# AWS EKS Playground
Playground for EKS AWS, written using terraform to learn how to deploy the service

Objectives:
 - [x] Create an EKS cluster (controll plane)
 - [x] Privison a managed node group (data plane)
 - [x] Enable adons, aws-ebs-csi-driver, coredns, vpc-cni and kube-proxy
 - [x] Bootstrap the EKS cluster with ArgoCD using EKS blueprints
 - [x] Deploy metric server for Kube
 - [ ] Deploy Nginx to the cluster via ArgoCD
 - [ ] Implement HPA for the Nginx deployment 
 - [ ] Expose Nginx via Ingres/Service that uses AWS ALB