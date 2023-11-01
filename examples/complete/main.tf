module "this" {
  source       = "../../"
  name         = "terraform-aws-ecr1"
  scan_on_push = true
  force_delete = true
}

module "share_with_accounts" {
  source           = "../../"
  name             = "terraform-aws-ecr2"
  scan_on_push     = true
  force_delete     = true
  trusted_accounts = ["266458841044", "432418664414"]
}

module "share_with_org" {
  source                      = "../../"
  name                        = "terraform-aws-ecr3"
  scan_on_push                = true
  force_delete                = true
  trusted_principal_org_paths = "o-685x712345/*"
}

