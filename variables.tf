variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "git" {
  description = "Name of the Git repo"
  type        = string
  default     = "terraform-aws-ecr"
}

variable "name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository#argument-reference"
  type        = string
}

variable "image_tag_mutability" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository#argument-reference"
  type        = string
  default     = "MUTABLE"
}

variable "encryption_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository#argument-reference"
  type        = string
  default     = "AES256"
}

variable "scan_on_push" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository#argument-reference"
  type        = bool
  default     = true
}

variable "trusted_accounts" {
  description = "trusted accounts that are allowed to pull images"
  type        = list(any)
  default     = null
}

variable "trusted_principal_org_paths" {
  description = "https://aws.amazon.com/blogs/containers/sharing-amazon-ecr-repositories-with-multiple-accounts-using-aws-organizations"
  type        = string
  default     = null
}

variable "force_delete" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository#force_delete"
  type        = bool
  default     = false
}

variable "image_limit" {
  description = "If not null, a default lifecycle policy will be deployed to prune repository images to this limit"
  type        = number
  default     = 8000
}
