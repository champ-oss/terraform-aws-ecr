terraform {
  required_version = ">= 1.5.0"
}

module "share_with_org" {
  source                      = "../../"
  name                        = "terraform-aws-ecr3"
  force_delete                = true
  trusted_principal_org_paths = "o-685x712345/*"
}

