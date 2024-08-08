output "dns_zone_name" {
  description = "The name of the DNS zone"
  value       = google_dns_managed_zone.dns_zone.name
}

output "dns_zone_name_servers" {
  description = "The name servers for the DNS zone"
  value       = google_dns_managed_zone.dns_zone.name_servers
}

output "dns_zone_id" {
  description = "The ID of the DNS zone"
  value       = google_dns_managed_zone.dns_zone.id
}
