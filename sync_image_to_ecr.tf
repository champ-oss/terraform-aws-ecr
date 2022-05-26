data "aws_region" "this" {}
data "aws_caller_identity" "this" {}

resource "null_resource" "sync_image_to_ecr" {
  count      = var.sync_image ? 1 : 0
  depends_on = [aws_ecr_repository.this]

  triggers = {
    ecr_name         = aws_ecr_repository.this.name
    sync_source_repo = var.sync_source_repo
    sync_source_tag  = var.sync_source_tag
  }

  provisioner "local-exec" {
    command     = "sh ${path.module}/sync_image_to_ecr.sh"
    interpreter = ["/bin/sh", "-c"]
    environment = {
      RETRIES     = var.sync_retries
      SLEEP       = var.sync_sleep_seconds
      AWS_REGION  = data.aws_region.this.name
      SOURCE_REPO = var.sync_source_repo
      IMAGE_TAG   = var.sync_source_tag
      ECR_ACCOUNT = data.aws_caller_identity.this.account_id
      ECR_NAME    = aws_ecr_repository.this.name
    }
  }
}