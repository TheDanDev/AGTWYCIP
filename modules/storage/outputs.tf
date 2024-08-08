output "storage_media_bucket_name" {
  description = "The name of the media storage bucket"
  value       = google_storage_bucket.storage_media_bucket.name
}

output "storage_backup_bucket_name" {
  description = "The name of the backup storage bucket"
  value       = google_storage_bucket.storage_backup_bucket.name
}

output "storage_cdn_backend_name" {
  description = "The name of the CDN backend bucket"
  value       = google_compute_backend_bucket.storage_cdn_backend.name
}

output "storage_cdn_url_map_name" {
  description = "The name of the CDN URL map"
  value       = google_compute_url_map.storage_cdn_url_map.name
}

output "storage_cdn_ip_address" {
  description = "The IP address of the CDN"
  value       = google_compute_global_forwarding_rule.storage_cdn_forwarding_rule.ip_address
}
