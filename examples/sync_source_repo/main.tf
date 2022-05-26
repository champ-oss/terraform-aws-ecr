provider "aws" {
  region = "us-east-1"
}

# Test syncing the latest ubuntu image to ECR
module "this" {
  source           = "../../"
  name             = "terraform-aws-ecr/ubuntu-test"
  sync_image       = true
  sync_source_repo = "ubuntu"
  sync_source_tag  = "latest"
}

# Verify the image and tag exist in ECR
data "aws_ecr_image" "this" {
  repository_name = "terraform-aws-ecr/ubuntu-test"
  image_tag       = "latest"
}