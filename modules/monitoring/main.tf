# Cloud Monitoring Dashboard
resource "google_monitoring_dashboard" "monitoring_dashboard" {
  dashboard_json = jsonencode({
    displayName = "Refurl Monitoring Dashboard"
    gridLayout = {
      columns = 2
      widgets = [
        {
          title   = "WordPress CPU Usage"
          xyChart = {
            dataSets = [{
              timeSeriesQuery = {
                timeSeriesFilter = {
                  filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" resource.type=\"gce_instance\" resource.label.\"instance_id\"=\"${var.wordpress_instance_id}\""
                }
              }
            }]
          }
        },
        {
          title   = "YOURLS CPU Usage"
          xyChart = {
            dataSets = [{
              timeSeriesQuery = {
                timeSeriesFilter = {
                  filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" resource.type=\"gce_instance\" resource.label.\"instance_id\"=\"${var.yourls_instance_id}\""
                }
              }
            }]
          }
        }
      ]
    }
  })
}

# Logging Sinks
resource "google_logging_project_sink" "monitoring_wordpress_sink" {
  name        = "monitoring-wordpress-sink"
  destination = "storage.googleapis.com/${google_storage_bucket.monitoring_log_bucket.name}"
  filter      = "resource.type = gce_instance AND resource.labels.instance_id = \"${var.wordpress_instance_id}\""

  unique_writer_identity = true
}

resource "google_logging_project_sink" "monitoring_yourls_sink" {
  name        = "monitoring-yourls-sink"
  destination = "storage.googleapis.com/${google_storage_bucket.monitoring_log_bucket.name}"
  filter      = "resource.type = gce_instance AND resource.labels.instance_id = \"${var.yourls_instance_id}\""

  unique_writer_identity = true
}

# Log Storage Bucket
resource "google_storage_bucket" "monitoring_log_bucket" {
  name     = "monitoring-log-bucket-${var.project_id}"
  location = var.region

  lifecycle_rule {
    condition {
      age = var.log_retention_days
    }
    action {
      type = "Delete"
    }
  }
}

# Custom Log-based Metric
resource "google_logging_metric" "monitoring_error_count" {
  name   = "monitoring-error-count"
  filter = "severity>=ERROR"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
    unit        = "1"
  }
}

# Alert Policy
resource "google_monitoring_alert_policy" "monitoring_error_alert" {
  display_name = "High Error Rate Alert"
  combiner     = "OR"
  conditions {
    display_name = "Error count threshold exceeded"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.monitoring_error_count.name}\" resource.type=\"gce_instance\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 10
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.monitoring_email.name]
}

# Notification Channel
resource "google_monitoring_notification_channel" "monitoring_email" {
  display_name = "Email Notification Channel"
  type         = "email"
  labels = {
    email_address = var.alert_email
  }
}

# Uptime Check
resource "google_monitoring_uptime_check_config" "monitoring_wordpress_uptime" {
  display_name = "WordPress Uptime Check"
  timeout      = "10s"
  period       = "60s"

  http_check {
    path         = "/"
    port         = "443"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = var.wordpress_domain
    }
  }
}

resource "google_monitoring_uptime_check_config" "monitoring_yourls_uptime" {
  display_name = "YOURLS Uptime Check"
  timeout      = "10s"
  period       = "60s"

  http_check {
    path         = "/"
    port         = "443"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = var.yourls_domain
    }
  }
}
