// aws_rds_cluster
output "this_rds_cluster_arn" {
  description = "The ID of the cluster"
  value       = aws_rds_cluster.this.arn
}

output "this_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = aws_rds_cluster.this.id
}

output "this_rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = aws_rds_cluster.this.cluster_resource_id
}

output "this_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = aws_rds_cluster.this.endpoint
}

output "this_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = aws_rds_cluster.this.reader_endpoint
}

output "this_rds_cluster_port" {
  description = "The port"
  value       = aws_rds_cluster.this.port
}

output "this_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.this.*.endpoint
}

output "this_security_group_id" {
  description = "The security group ID of the cluster"
  value       = local.rds_security_group_id
}

output "aws_rds_cluster_this_username" {
  description = "The security group ID of the cluster"
  value       = aws_rds_cluster.this.master_username
}

output "aws_rds_cluster_this_password" {
  description = "The security group ID of the cluster"
  value       = aws_rds_cluster.this.master_password
}