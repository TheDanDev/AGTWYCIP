output "network_name" {
  value       = google_compute_network.network_vpc.name
  description = "The name of the VPC being created"
}

output "network_id" {
  value       = google_compute_network.network_vpc.id
  description = "The ID of the VPC being created"
}

output "network_self_link" {
  value       = google_compute_network.network_vpc.self_link
  description = "The URI of the VPC being created"
}

output "subnets" {
  value       = google_compute_subnetwork.network_subnets
  description = "The created subnet resources"
}

output "nat_ip" {
  value       = google_compute_router_nat.network_nat.nat_ips
  description = "The NAT IP addresses"
}
