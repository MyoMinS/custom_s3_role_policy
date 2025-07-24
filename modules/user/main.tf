resource "aws_iam_user" "user" {
  name = "custom-s3-access"
  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_policy" "policy" {
  name        = "custom-s3-policy"
  description = "A test policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::data-analyst-share-bucket-yoma/*"
      },
    ]
  })
}


resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}