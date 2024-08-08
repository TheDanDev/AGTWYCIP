resource "google_compute_instance" "compute_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.instance_image
      size  = var.boot_disk_size
      type  = var.boot_disk_type
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = file(var.startup_script_path)

  tags = concat(["http-server", "https-server", "ssh"], var.additional_tags)

  service_account {
    email  = google_service_account.compute_service_account.email
    scopes = ["cloud-platform"]
  }

  allow_stopping_for_update = true
}

resource "google_service_account" "compute_service_account" {
  account_id   = "compute-sa-${var.instance_name}"
  display_name = "Compute Instance Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "compute_sa_roles" {
  for_each = toset(var.service_account_roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.compute_service_account.email}"
}
