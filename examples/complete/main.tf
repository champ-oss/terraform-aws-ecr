module "this" {
  source       = "../../"
  name         = "terraform-aws-ecr"
  scan_on_push = true
  force_delete = true
}
