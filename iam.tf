# cluster role resources
data "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster" {
  name                  = "ESKClusterRole"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.eks_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = data.aws_iam_policy.eks_cluster_policy.arn
}

data "aws_iam_policy" "eks_cluster_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# node group resoures
locals {
  node_group_policies = {
    amazoneks_cni_policy                         = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    amazonec2_container_registry_readonly_policy = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    amazoneks_worker_node_policy                 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  }
}

data "aws_iam_policy_document" "eks_node_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_node_group" {
  name                  = "EKSNodeGroupRole"
  force_detach_policies = true
  assume_role_policy    = data.aws_iam_policy_document.eks_node_assume_role_policy.json
}

data "aws_iam_policy" "eks_node_group_policy" {
  for_each = local.node_group_policies

  arn = each.value
}

resource "aws_iam_role_policy_attachment" "eks_node_group" {
  for_each = local.node_group_policies

  role       = aws_iam_role.eks_node_group.name
  policy_arn = data.aws_iam_policy.eks_node_group_policy[each.key].arn
}


