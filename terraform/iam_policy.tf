resource "aws_iam_policy" "s3_access_policy" {
  name_prefix = "eks-s3-access-policy-"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:Get*",
          "s3:List*",
        ]
        Resource = "*"
      },
    ]
  })
}