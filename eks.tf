
# cluster role resources
resource "aws_eks_cluster" "main" {
  name     = "example"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [for key, _ in local.subnets.private : aws_subnet.private[key].id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster
  ]
}

output "endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}

