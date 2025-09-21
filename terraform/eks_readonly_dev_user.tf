# Terraform configuration to create an IAM user with read-only EKS access

resource "aws_iam_user" "eks_readonly_dev" {
  name = "eks-readonly-dev"
}

resource "aws_iam_access_key" "eks_readonly_dev" {
  user = aws_iam_user.eks_readonly_dev.name
}

resource "aws_iam_user_policy_attachment" "eks_readonly_dev_eks_readonly" {
  user       = aws_iam_user.eks_readonly_dev.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSReadOnlyAccess"
}

resource "aws_iam_user_policy_attachment" "eks_readonly_dev_cloudwatch_readonly" {
  user       = aws_iam_user.eks_readonly_dev.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

output "eks_readonly_dev_access_key_id" {
  value = aws_iam_access_key.eks_readonly_dev.id
}

output "eks_readonly_dev_secret_access_key" {
  value     = aws_iam_access_key.eks_readonly_dev.secret
  sensitive = true
}

# After applying, map this IAM user in your EKS aws-auth ConfigMap and create a Kubernetes ClusterRole/ClusterRoleBinding for read-only access.
# See README for RBAC instructions.