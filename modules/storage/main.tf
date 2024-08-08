# Media storage bucket
resource "google_storage_bucket" "storage_media_bucket" {
  name          = "storage-media-${var.project_id}"
  location      = var.region
  force_destroy = var.environment != "prod"

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = var.media_file_retention_days
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "SetStorageClass"
      storage_class = "NEARLINE"
    }
  }

  cors {
    origin          = var.allowed_origins
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

# Backup storage bucket
resource "google_storage_bucket" "storage_backup_bucket" {
  name          = "storage-backup-${var.project_id}"
  location      = var.region
  force_destroy = var.environment != "prod"

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = var.backup_retention_days
    }
    action {
      type = "Delete"
    }
  }
}

# Cloud CDN configuration
resource "google_compute_backend_bucket" "storage_cdn_backend" {
  name        = "storage-cdn-backend"
  bucket_name = google_storage_bucket.storage_media_bucket.name
  enable_cdn  = true
}

resource "google_compute_url_map" "storage_cdn_url_map" {
  name            = "storage-cdn-url-map"
  default_service = google_compute_backend_bucket.storage_cdn_backend.self_link
}

resource "google_compute_target_http_proxy" "storage_cdn_http_proxy" {
  name    = "storage-cdn-http-proxy"
  url_map = google_compute_url_map.storage_cdn_url_map.self_link
}

resource "google_compute_global_forwarding_rule" "storage_cdn_forwarding_rule" {
  name       = "storage-cdn-forwarding-rule"
  target     = google_compute_target_http_proxy.storage_cdn_http_proxy.self_link
  port_range = "80"
}

# IAM policy for media bucket
resource "google_storage_bucket_iam_binding" "storage_media_bucket_iam" {
  bucket = google_storage_bucket.storage_media_bucket.name
  role   = "roles/storage.objectViewer"
  members = var.media_bucket_viewers
}

# IAM policy for backup bucket
resource "google_storage_bucket_iam_binding" "storage_backup_bucket_iam" {
  bucket = google_storage_bucket.storage_backup_bucket.name
  role   = "roles/storage.objectAdmin"
  members = var.backup_bucket_admins
}
