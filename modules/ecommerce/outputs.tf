output "ecommerce_instance_ip" {
  value       = google_compute_instance.ecommerce_instance.network_interface[0].access_config[0].nat_ip
  description = "The public IP address of the e-commerce instance"
}

output "inventory_api_url" {
  value       = google_cloud_run_service.inventory_api.status[0].url
  description = "The URL of the inventory API service"
}

output "ecommerce_service_account" {
  value       = google_service_account.ecommerce_sa.email
  description = "The email of the e-commerce service account"
}
