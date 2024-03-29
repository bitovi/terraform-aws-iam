provider "aws" {
  region = var.aws_region
}

resource "aws_iam_user" "opsly_tf_user" {
  name = "opsly_tf_user"
}

resource "aws_iam_access_key" "opsly_tf_user_key" {
  user = aws_iam_user.opsly_tf_user.name
}

# Attach AWS-managed ReadOnlyAccess policy to the IAM user
resource "aws_iam_user_policy_attachment" "read_only_access" {
  user       = aws_iam_user.opsly_tf_user.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role" "opsly_tf_role" {
  name = "OpslyTfRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          AWS = aws_iam_user.opsly_tf_user.arn
        },
        Effect = "Allow",
        Sid    = ""
      },
    ]
  })
}

# Attach AWS-managed ReadOnlyAccess policy to the IAM role
resource "aws_iam_role_policy_attachment" "read_only_access_role" {
  role       = aws_iam_role.opsly_tf_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

output "access_key" {
  value = aws_iam_access_key.opsly_tf_user_key.id
}

# to get the secret key:
# terraform output -raw secret_access_key
output "secret_access_key" {
  value = aws_iam_access_key.opsly_tf_user_key.secret
  sensitive = true
}

output "user_arn" {
  value = aws_iam_user.opsly_tf_user.arn
}

output "role_arn" {
  value = aws_iam_role.opsly_tf_role.arn
}

output "region" {
  value = var.aws_region
}
