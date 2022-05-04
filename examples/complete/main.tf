provider "aws" {
  region = "us-east-1"
}

module "this" {
  for_each = toset(var.repositories)
  source   = "../../"
  name     = each.value
}
