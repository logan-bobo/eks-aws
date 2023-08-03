
# controll plane resources
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

# data plane resources

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "example"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = [for _, v in aws_subnet.private: v.id]
  capacity_type = "SPOT"

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    data.aws_iam_policy.eks_node_group_policy
  ]
}
