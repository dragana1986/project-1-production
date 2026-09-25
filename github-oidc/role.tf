resource "aws_iam_role" "github_actions_terraform" {
  name = "project-1-github-actions-terraform"

  assume_role_policy = data.aws_iam_policy_document.github_actions_trust.json

  description = "Terraform CI role assumed by GitHub Actions through OIDC"

  tags = {
    Project   = "project-1"
    ManagedBy = "Terraform"
    Purpose   = "github-actions-terraform"
  }
}
