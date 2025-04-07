terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.94.1"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "tf_backend_bucket" {
  bucket = "terraform-eks-state-lock-bucket-ardit"
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_dynamodb_table" "basic_dyno_table" {
  name           = "terraform-eks-state-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
