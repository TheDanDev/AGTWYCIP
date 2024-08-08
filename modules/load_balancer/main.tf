resource "google_compute_global_address" "lb_ipv4" {
  name         = "lb-ipv4-address"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

resource "google_compute_global_forwarding_rule" "lb_http" {
  name       = "lb-http-forwarding-rule"
  target     = google_compute_target_http_proxy.lb_http_proxy.self_link
  port_range = "80"
  ip_address = google_compute_global_address.lb_ipv4.address
}

resource "google_compute_global_forwarding_rule" "lb_https" {
  name       = "lb-https-forwarding-rule"
  target     = google_compute_target_https_proxy.lb_https_proxy.self_link
  port_range = "443"
  ip_address = google_compute_global_address.lb_ipv4.address
}

resource "google_compute_target_http_proxy" "lb_http_proxy" {
  name    = "lb-http-proxy"
  url_map = google_compute_url_map.lb_url_map.self_link
}

resource "google_compute_target_https_proxy" "lb_https_proxy" {
  name             = "lb-https-proxy"
  url_map          = google_compute_url_map.lb_url_map.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.lb_ssl_cert.self_link]
}

resource "google_compute_managed_ssl_certificate" "lb_ssl_cert" {
  name = "lb-managed-ssl-cert"
  managed {
    domains = [var.domain_name]
  }
}

resource "google_compute_url_map" "lb_url_map" {
  name            = "lb-url-map"
  default_service = google_compute_backend_service.lb_backend_wordpress.self_link

  host_rule {
    hosts        = [var.domain_name]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.lb_backend_wordpress.self_link

    path_rule {
      paths   = ["/yourls/*"]
      service = google_compute_backend_service.lb_backend_yourls.self_link
    }
  }
}

resource "google_compute_backend_service" "lb_backend_wordpress" {
  name                  = "lb-backend-wordpress"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 30
  health_checks         = [google_compute_health_check.lb_health_check.self_link]

  backend {
    group = var.wordpress_instance_group
  }
}

resource "google_compute_backend_service" "lb_backend_yourls" {
  name                  = "lb-backend-yourls"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 30
  health_checks         = [google_compute_health_check.lb_health_check.self_link]

  backend {
    group = var.yourls_instance_group
  }
}

resource "google_compute_health_check" "lb_health_check" {
  name               = "lb-health-check"
  check_interval_sec = 5
  timeout_sec        = 5

  http_health_check {
    port         = 80
    request_path = "/health"
  }
}

resource "google_compute_firewall" "lb_fw_allow_health_check" {
  name    = "lb-fw-allow-health-check"
  network = var.vpc_network

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["load-balanced-backend"]
}
