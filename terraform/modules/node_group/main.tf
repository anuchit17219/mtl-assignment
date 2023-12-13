resource "aws_eks_node_group" "node_group" {
  cluster_name = var.EKS_CLUSTER_NAME
  node_group_name = "${var.EKS_CLUSTER_NAME}-node-group"
  node_role_arn = var.NODE_GROUP_ROLE_ARN

  # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
  # These subnets must have the following resource tag: kubernetes.io/cluster/EKS_CLUSTER_NAME 
  subnet_ids = [
    var.PRI_SUB3_ID,
    var.PRI_SUB4_ID
  ]

  # Configuration block
  scaling_config {
    desired_size = 2
    max_size = 2
    min_size = 1
  }

  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group
  ami_type = "AL2_x86_64"

  # Type of capacity associated with the EKS Node Group
  capacity_type = "ON_DEMAND"

  # Disk size in GB for worker nodes
  disk_size = 20

  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue
  force_update_version = false

  # Instance type associated with the EKS Node Group
  instance_types = ["t3.large"]

  labels = {
    role = "${var.EKS_CLUSTER_NAME}-Node-group-role",
    name = "${var.EKS_CLUSTER_NAME}-node-group"
  }

  # Kubernetes version
  version = "1.27"
}