terraform {
  backend "s3" {
    bucket         = "frankfurt-test-learning"
    key            = "managing/fiels12/global/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

# Route53 zone is shared across staging and production
resource "aws_route53_zone" "primary" {
  name = "frankfurttestlearning.com"
}
