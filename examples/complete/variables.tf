variable "repositories" {
  description = "list of the repos to test creating in aws ecr"
  type        = list(string)
  default     = []
}
