terraform {
  backend "s3" {
    bucket       = "project-1-production-terraform-state"
    key          = "bootstrap/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}