locals {
  tags = {
    cost    = "shared"
    creator = "terraform"
    git     = var.git
  }

  policy = {
    rules = [
      {
        rulePriority = 1
        description  = "image count limit"
        action       = { type = "expire" }

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = var.image_limit
        }
      }
    ]
  }
}

resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability
  tags                 = merge(local.tags, var.tags)
  force_delete         = var.force_delete

  encryption_configuration {
    encryption_type = var.encryption_type
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  lifecycle {
    ignore_changes = [
      # ignore kms repos that were manually created and can't be migrated without destroy
      encryption_configuration["encryption_type"]
    ]
  }
}

resource "aws_ecr_repository_policy" "ecr_policy" {
  count      = var.trusted_accounts != null || var.trusted_principal_org_paths != null ? 1 : 0
  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.resource_readonly_access[0].json
}

data "aws_iam_policy_document" "resource_readonly_access" {
  count = var.trusted_accounts != null ? 1 : 0

  dynamic "statement" {
    for_each = var.trusted_accounts != null ? [1] : []
    content {
      sid    = "account-access"
      effect = "Allow"

      principals {
        type        = "AWS"
        identifiers = var.trusted_accounts
      }

      principals {
        type = "Service"
        identifiers = [
          "ec2.amazonaws.com",
          "lambda.amazonaws.com"
        ]
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

  dynamic "statement" {
    for_each = var.trusted_principal_org_paths != null ? [1] : []
    content {
      sid    = "org-access"
      effect = "Allow"

      principals {
        type = "Service"
        identifiers = [
          "ec2.amazonaws.com",
          "lambda.amazonaws.com"
        ]
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

      condition {
        test     = "ForAnyValue:StringLike"
        variable = "aws:PrincipalOrgPaths"
        values   = [var.trusted_principal_org_paths]
      }
    }
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  count      = var.image_limit != null ? 1 : 0
  repository = aws_ecr_repository.this.name
  policy     = jsonencode(local.policy)
}
