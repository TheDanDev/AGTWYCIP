output "wordpress_instance_name" {
  description = "The name of the WordPress instance"
  value       = google_compute_instance.wordpress_instance.name
}

output "wordpress_instance_ip" {
  description = "The internal IP of the WordPress instance"
  value       = google_compute_instance.wordpress_instance.network_interface[0].network_ip
}

output "wordpress_service_account" {
  description = "The email of the WordPress service account"
  value       = google_service_account.wordpress_sa.email
}

output "wordpress_cache_host" {
  description = "The host of the WordPress Redis cache"
  value       = google_redis_instance.wordpress_cache.host
}
