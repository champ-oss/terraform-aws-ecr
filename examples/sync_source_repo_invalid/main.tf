provider "aws" {
  region = "us-east-1"
}

# Test syncing an non-existent image to validate the script retries and times out
module "invalid" {
  source             = "../../"
  name               = "terraform-aws-ecr/invalid-test"
  sync_image         = true
  sync_source_repo   = "champtitles/foo"
  sync_source_tag    = "foobar"
  sync_retries       = 3
  sync_sleep_seconds = 1
}
