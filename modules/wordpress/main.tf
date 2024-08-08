resource "google_compute_instance" "wordpress_instance" {
  name         = "wordpress-${var.environment}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = var.network
    subnetwork = var.subnetwork
  }

  metadata_startup_script = templatefile("${path.module}/scripts/wordpress_setup.sh", {
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
    db_host     = var.db_host
    multisite   = var.enable_multisite
    redis_host  = var.redis_host
    domain      = var.domain
  })

  service_account {
    email  = google_service_account.wordpress_sa.email
    scopes = ["cloud-platform"]
  }

  allow_stopping_for_update = true
}

resource "google_service_account" "wordpress_sa" {
  account_id   = "wordpress-sa-${var.environment}"
  display_name = "WordPress Service Account"
}

resource "google_project_iam_member" "wordpress_sa_roles" {
  for_each = toset([
    "roles/storage.objectViewer",
    "roles/redis.editor",
  ])
  role    = each.key
  member  = "serviceAccount:${google_service_account.wordpress_sa.email}"
  project = var.project_id
}

resource "google_compute_firewall" "wordpress_firewall" {
  name    = "allow-wordpress-${var.environment}"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.allowed_ips
  target_tags   = ["wordpress"]
}

resource "google_redis_instance" "wordpress_cache" {
  name           = "wordpress-cache-${var.environment}"
  tier           = "BASIC"
  memory_size_gb = 1

  location_id             = var.zone
  alternative_location_id = var.failover_zone

  authorized_network = var.network

  redis_version     = "REDIS_6_X"
  display_name      = "WordPress Object Cache"
}
