#create EKS Cluster eks_cluster

resource "aws_eks_cluster" "eks_cluster" {
  name  = var.PROJECT_NAME
  role_arn = var.EKS_CLUSTER_ROLE_ARN

  version = "1.27"
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    subnet_ids = [
        var.PUB_SUB1_ID,
        var.PUB_SUB2_ID,
        var.PRI_SUB3_ID,
        var.PRI_SUB4_ID
        ]
  }
}