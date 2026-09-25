data "aws_iam_policy_document" "terraform_state_access" {

  statement {
    sid    = "ListTerraformStateBucket"
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::project-1-production-terraform-state"
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "environments/dev/*",
        "environments/staging/*",
        "environments/prod/*"
      ]
    }
  }

  statement {
    sid    = "ReadWriteTerraformState"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::project-1-production-terraform-state/environments/dev/terraform.tfstate",
      "arn:aws:s3:::project-1-production-terraform-state/environments/staging/terraform.tfstate",
      "arn:aws:s3:::project-1-production-terraform-state/environments/prod/terraform.tfstate"
    ]
  }

  statement {
    sid    = "TerraformStateLocking"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::project-1-production-terraform-state/environments/dev/terraform.tfstate.tflock",
      "arn:aws:s3:::project-1-production-terraform-state/environments/staging/terraform.tfstate.tflock",
      "arn:aws:s3:::project-1-production-terraform-state/environments/prod/terraform.tfstate.tflock"
    ]
  }

  statement {
    sid    = "UseTerraformStateKmsKey"
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey"
    ]

    resources = [
      "arn:aws:kms:us-east-1:222634382766:key/cb615043-6579-41e6-82fe-22fa378653e4"
    ]
  }
}

resource "aws_iam_policy" "terraform_state_access" {
  name        = "project-1-terraform-state-access"
  description = "Allows GitHub Actions Terraform role to access environments in the Terraform state bucket"

  policy = data.aws_iam_policy_document.terraform_state_access.json
}

resource "aws_iam_role_policy_attachment" "terraform_state_access" {
  role       = aws_iam_role.github_actions_terraform.name
  policy_arn = aws_iam_policy.terraform_state_access.arn
}
