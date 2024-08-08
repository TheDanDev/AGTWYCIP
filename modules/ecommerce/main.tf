resource "google_compute_instance" "ecommerce_instance" {
  name         = "ecommerce-instance-${var.environment}"
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

  metadata_startup_script = templatefile("${path.module}/scripts/ecommerce_setup.sh", {
    wordpress_db_name     = var.wordpress_db_name
    wordpress_db_user     = var.wordpress_db_user
    wordpress_db_password = var.wordpress_db_password
    wordpress_db_host     = var.wordpress_db_host
  })

  service_account {
    scopes = ["cloud-platform"]
  }

  tags = ["ecommerce", "http-server", "https-server"]
}

resource "google_compute_firewall" "ecommerce_firewall" {
  name    = "allow-ecommerce-${var.environment}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ecommerce"]
}

resource "google_cloud_run_service" "inventory_api" {
  name     = "inventory-api-${var.environment}"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/inventory-api:latest"
        env {
          name  = "DB_CONNECTION_STRING"
          value = var.inventory_db_connection_string
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "inventory_api_invoker" {
  service  = google_cloud_run_service.inventory_api.name
  location = google_cloud_run_service.inventory_api.location
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.ecommerce_sa.email}"
}

resource "google_service_account" "ecommerce_sa" {
  account_id   = "ecommerce-sa-${var.environment}"
  display_name = "E-commerce Service Account"
}

resource "google_project_iam_member" "ecommerce_sa_roles" {
  for_each = toset([
    "roles/cloudsql.client",
    "roles/secretmanager.secretAccessor",
    "roles/storage.objectViewer"
  ])

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.ecommerce_sa.email}"
}
