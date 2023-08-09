# AWS EKS Playground
Playground for EKS AWS, written using terraform to learn how to deploy the service

Objectives:
 - [x] Create an EKS cluster (controll plane)
 - [x] Privison a managed node group (data plane)
 - [x] Enable adons, aws-ebs-csi-driver, coredns, vpc-cni and kube-proxy
 - [x] Bootstrap the EKS cluster with ArgoCD using EKS blueprints
 - [x] Deploy metric server for Kube
 - [x] Deploy [nginx-app](https://github.com/logan-bobo/kube_nginx) to the cluster via ArgoCD
 - [x] Expose nginx-app via Ingres/Service that uses AWS ALB
 - [ ] Implement HPA for the nginx-app deployment 