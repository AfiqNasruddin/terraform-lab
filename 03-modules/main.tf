terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "ap-southeast-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://127.0.0.1:4566"
  }
}

module "demo_bucket" {
  source = "./modules/s3-bucket"
  bucket_name   = "my-module-bucket-01"
  force_destroy = true

  tags = {
    Environment = "learning"
    Owner       = "jack"
  }
}

module "demo2_bucket" {
  source = "./modules/s3-bucket"
  bucket_name   = "my-module-bucket-02"
  force_destroy = true

  tags = {
    Environment = "learning"
    Owner       = "jack"
    Purpose     = "second-bucket"
  }
}

module "website_bucket" {
  source      = "./modules/s3-website"
  bucket_name = "my-website-bucket-01"

  tags = {
    Environment = "learning"
    Owner       = "jack"
    Purpose     = "static-website"
  }
}

output "bucket_01_name" {
  value = module.demo_bucket.bucket_id
}

output "bucket_01_arn" {
  value = module.demo_bucket.bucket_arn
}

output "bucket_02_name" {
  value = module.demo2_bucket.bucket_id
}

output "bucket_02_arn" {
  value = module.demo2_bucket.bucket_arn
}

output "website_bucket_name" {
  value = module.website_bucket.bucket_id
}

output "website_endpoint" {
  value = module.website_bucket.website_endpoint
}
