terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "terraform-state-file-store-mms"
    key = "role/role-s3.tfstate"
    region = "ap-southeast-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source = "./modules/s3"
  role_arn = module.iam.role_arn
}

module "user" {
  source = "./modules/user"
}