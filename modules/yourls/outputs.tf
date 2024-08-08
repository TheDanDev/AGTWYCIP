output "yourls_instance_ip" {
  value       = google_compute_instance.yourls_instance.network_interface[0].access_config[0].nat_ip
  description = "The public IP address of the YOURLS instance"
}

output "yourls_domain" {
  value       = google_dns_record_set.yourls_dns.name
  description = "The domain name for YOURLS"
}

output "yourls_api_url" {
  value       = google_cloud_run_service.yourls_api.status[0].url
  description = "The URL of the YOURLS API service"
}
