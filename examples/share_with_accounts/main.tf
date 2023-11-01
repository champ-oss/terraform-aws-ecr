module "share_with_accounts" {
  source           = "../../"
  name             = "terraform-aws-ecr2"
  force_delete     = true
  trusted_accounts = ["266458841044", "432418664414"]
}
