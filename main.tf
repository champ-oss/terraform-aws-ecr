locals {
  tags = {
    cost    = "shared"
    creator = "terraform"
    git     = var.git
  }
}

resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability
  tags                 = merge(local.tags, var.tags)

  encryption_configuration {
    encryption_type = var.encryption_type
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_ecr_repository_policy" "ecr_policy" {
  count      = var.trusted_accounts != [] ? 0 : 1
  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.resource_readonly_access.json
}

data "aws_iam_policy_document" "resource_readonly_access" {

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.trusted_accounts
    }

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
    ]
  }
}