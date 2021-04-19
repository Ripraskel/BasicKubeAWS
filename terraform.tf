
terraform {

  required_version = "~> 0.14"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "dev-ops-terraform-rpskott"
    key    = "basic-eks-cluster-on-aws"
    region = "eu-west-2"
  }
  
}

provider "aws" {
  region = "eu-west-2"
}


