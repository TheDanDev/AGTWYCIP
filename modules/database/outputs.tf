output "database_wordpress_connection_name" {
  description = "The connection name for the WordPress database instance"
  value       = google_sql_database_instance.database_wordpress_primary.connection_name
}

output "database_wordpress_private_ip" {
  description = "The private IP address for the WordPress database instance"
  value       = google_sql_database_instance.database_wordpress_primary.private_ip_address
}

output "database_wordpress_replica_connection_name" {
  description = "The connection name for the WordPress read replica"
  value       = var.create_read_replica ? google_sql_database_instance.database_wordpress_replica[0].connection_name : null
}

output "database_yourls_connection_name" {
  description = "The connection name for the YOURLS database instance"
  value       = google_sql_database_instance.database_yourls_primary.connection_name
}

output "database_yourls_private_ip" {
  description = "The private IP address for the YOURLS database instance"
  value       = google_sql_database_instance.database_yourls_primary.private_ip_address
}

output "database_yourls_replica_connection_name" {
  description = "The connection name for the YOURLS read replica"
  value       = var.create_read_replica ? google_sql_database_instance.database_yourls_replica[0].connection_name : null
}
