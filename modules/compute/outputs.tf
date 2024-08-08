output "instance_name" {
  description = "The name of the compute instance"
  value       = google_compute_instance.compute_instance.name
}

output "instance_id" {
  description = "The ID of the compute instance"
  value       = google_compute_instance.compute_instance.id
}

output "instance_self_link" {
  description = "The self-link of the compute instance"
  value       = google_compute_instance.compute_instance.self_link
}

output "instance_internal_ip" {
  description = "The internal IP of the compute instance"
  value       = google_compute_instance.compute_instance.network_interface[0].network_ip
}

output "instance_external_ip" {
  description = "The external IP of the compute instance"
  value       = google_compute_instance.compute_instance.network_interface[0].access_config[0].nat_ip
}

output "service_account_email" {
  description = "The email of the service account associated with the compute instance"
  value       = google_service_account.compute_service_account.email
}
