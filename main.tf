terraform {
  backend "s3" {
    bucket = "244190102671-lina-figueredo"
    key    = "terraform/state.tfstate"
    region = "us-east-1"
  }
  
  required_providers {
    aws = {
      version = ">= 5.52.0"
    }
  }
  required_version = ">= 1.1.7"
}

provider "aws" {
  region = "us-east-1"
}

# resource "aws_s3_bucket" "fer-gha-tf-bucket" {
#   bucket = "244190102671-lina-figueredo"

#     tags = {
#         Owner = "lina-figueredo"
#         bootcamp = "devops"
#     }
# }
