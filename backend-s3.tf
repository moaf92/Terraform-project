terraform {
  backend "s3" {
    bucket = "terra-project-state00"
    key    = "terraform/backend"
    region = "us-east-1"

  }
}