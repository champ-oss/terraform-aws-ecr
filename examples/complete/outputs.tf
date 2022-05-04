output "registry_id" {
  value       = [for s in module.this : s.registry_id[*]]
  description = "repository id"
}

output "repository_url" {
  value       = [for s in module.this : s.repository_url[*]]
  description = "URL of first repository created"
}
