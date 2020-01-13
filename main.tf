terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "spring-petclinic-iac-state"
    key    = "terraform.tfstate"
  }
}

data "aws_caller_identity" "current" {}
