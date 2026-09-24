terraform {
  backend "s3" {
    bucket       = "project-1-production-terraform-state"
    key          = "environments/staging/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
    kms_key_id   = "arn:aws:kms:us-east-1:222634382766:key/cb615043-6579-41e6-82fe-22fa378653e4"
  }
}