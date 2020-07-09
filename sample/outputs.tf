output "this_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = module.aurora.this_rds_cluster_instance_endpoints
}

output "this_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.aurora.this_rds_cluster_endpoint
}

output "this_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = module.aurora.this_rds_cluster_reader_endpoint
}
output "this_rds_cluster_port" {
  description = "The port"
  value       = module.aurora.this_rds_cluster_port
}
