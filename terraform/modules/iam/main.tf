# aws_iam_role.cluster-ServiceRole will be created
resource "aws_iam_role" "eks_cluster_iam_role" {
  name = "${var.PROJECT_NAME}-EKS-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_cluster_iam_role.name
}


# Create IAM role for EKS Node Group
resource "aws_iam_role" "node_group" {
  name = "${var.PROJECT_NAME}-node-group-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Create an IAM policy for the S3
resource "aws_iam_policy" "s3" {
  name   = "${var.PROJECT_NAME}-s3-policy"
  description = "Allows access to the S3"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::my-web-assets)"
    }
  ]
}
EOF
}

# Create an IAM policy for the SQS queue
resource "aws_iam_policy" "sqs" {
  name        = "${var.PROJECT_NAME}-sqs-policy"
  description = "Allows access to the SQS queue"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage"
      ],
      "Resource": "arn:aws:sqs:ap-southeast-1:123456789123:lms-import-data"
    }
  ]
}
EOF
}

# Attach the S3 policy to the IAM role
resource "aws_iam_role_policy_attachment" "s3" {
  policy_arn = aws_iam_policy.s3.arn
  role       = aws_iam_role.node_group.name
}

# Attach the SQS queue policy to the IAM role
resource "aws_iam_role_policy_attachment" "sqs" {
  policy_arn = aws_iam_policy.sqs.arn
  role       = aws_iam_role.node_group.name
}
