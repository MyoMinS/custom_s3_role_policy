resource "aws_s3_bucket" "bucket" {
  bucket = "data-analyst-share-bucket-yoma"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Entity = "GSS"
    Sub-Tag = "GSS"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_role.json
}

data "aws_iam_policy_document" "allow_access_from_role" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["582368452665"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}
