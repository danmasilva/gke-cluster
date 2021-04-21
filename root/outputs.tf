output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "rancher_cluster_address" {
  value       = module.main-infra.rancher_server_address
  description = "Rancher Cluster Host"
}
