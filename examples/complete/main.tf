module "this" {
  source       = "../../"
  name         = "terraform-aws-ecr1"
  scan_on_push = true
  force_delete = true
}
