resource "google_compute_instance" "yourls_instance" {
  name         = "yourls-instance"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = file("${path.module}/scripts/yourls_setup.sh")

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_dns_record_set" "yourls_dns" {
  name         = "yourls.${var.domain_name}."
  managed_zone = var.dns_zone
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_instance.yourls_instance.network_interface[0].access_config[0].nat_ip]
}

resource "google_compute_firewall" "yourls_firewall" {
  name    = "allow-yourls"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["yourls"]
}

resource "google_cloud_run_service" "yourls_api" {
  name     = "yourls-api"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/yourls-api:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "yourls_api_invoker" {
  service  = google_cloud_run_service.yourls_api.name
  location = google_cloud_run_service.yourls_api.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
