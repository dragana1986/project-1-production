variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "tfstate_bucket_name" {
  description = "The name of the S3 bucket to store Terraform state"
  type        = string
}