output "lb_ip_address" {
  description = "The IP address of the load balancer"
  value       = google_compute_global_address.lb_ipv4.address
}

output "lb_http_proxy" {
  description = "The HTTP proxy for the load balancer"
  value       = google_compute_target_http_proxy.lb_http_proxy.self_link
}

output "lb_https_proxy" {
  description = "The HTTPS proxy for the load balancer"
  value       = google_compute_target_https_proxy.lb_https_proxy.self_link
}

output "lb_backend_wordpress" {
  description = "The backend service for WordPress"
  value       = google_compute_backend_service.lb_backend_wordpress.self_link
}

output "lb_backend_yourls" {
  description = "The backend service for YOURLS"
  value       = google_compute_backend_service.lb_backend_yourls.self_link
}
