terraform {
  backend "s3" {
    bucket         = "frankfurt-test-learning"
    key            = "managing/files12/staging/terraform.tfstate"
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

variable "db_pass" {
  description = "password for database"
  type        = string
  sensitive   = true
}

locals {
  environment_name = "staging"
}

module "web_app" {
  source = "../../../organization-and-modules/web-app-module"

  # Input Variables
  bucket_prefix    = "frankfurt-web-app-data-${local.environment_name}"
  domain           = "frankfurttestlearning.com"
  environment_name = local.environment_name
  instance_type    = "t2.micro"
  create_dns_zone  = false
  db_name          = "${local.environment_name}mydb"
  db_user          = "foo"
  db_pass          = var.db_pass
}
