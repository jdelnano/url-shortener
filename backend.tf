# NOTE:  update the S3 bucket field to a real name that exists in your AWS account
terraform {
  required_version = "> 0.13.0"
  backend "s3" {
    bucket = "terraform-<accountId>-us-east-1"
    key    = "terraform-url-shortener-test.tfstate"
    region = "us-east-1"
  }
}
