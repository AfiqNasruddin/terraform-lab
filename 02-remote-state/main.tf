terraform {
  backend "s3" {
    bucket                      = "tfstate-localstack"
    key                         = "demo/terraform.tfstate"
    region                      = "ap-southeast-1"
    endpoints = {
      s3 = "http://127.0.0.1:4566"
    }
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
    use_lockfile                = true          # ← new native locking
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "ap-southeast-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3       = "http://127.0.0.1:4566"
    dynamodb = "http://127.0.0.1:4566"
  }
}

resource "aws_s3_bucket" "demo" {
  bucket = "my-remote-state-demo-01"
}
