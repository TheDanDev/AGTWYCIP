resource "google_compute_network" "network_vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "network_subnets" {
  for_each      = var.subnets
  name          = "network-${each.key}-subnet"
  ip_cidr_range = each.value.cidr
  region        = each.value.region
  network       = google_compute_network.network_vpc.id
  project       = var.project_id

  private_ip_google_access = true

  secondary_ip_range = [
    for i, range in each.value.secondary_ranges :
    {
      range_name    = "network-${each.key}-secondary-${i}"
      ip_cidr_range = range
    }
  ]
}

resource "google_compute_firewall" "network_allow_http_https" {
  name    = "network-allow-http-https"
  network = google_compute_network.network_vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server", "https-server"]
}

resource "google_compute_firewall" "network_allow_ssh" {
  name    = "network-allow-ssh"
  network = google_compute_network.network_vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges
  target_tags   = ["ssh"]
}

resource "google_compute_router" "network_router" {
  name    = "network-router"
  network = google_compute_network.network_vpc.id
  region  = var.region
  project = var.project_id
}

resource "google_compute_router_nat" "network_nat" {
  name                               = "network-nat"
  router                             = google_compute_router.network_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  project                            = var.project_id
}
