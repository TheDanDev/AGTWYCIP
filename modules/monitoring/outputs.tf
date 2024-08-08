output "monitoring_dashboard_name" {
  description = "The name of the monitoring dashboard"
  value       = google_monitoring_dashboard.monitoring_dashboard.dashboard_json
}

output "monitoring_log_bucket" {
  description = "The name of the log storage bucket"
  value       = google_storage_bucket.monitoring_log_bucket.name
}

output "monitoring_error_metric" {
  description = "The name of the custom error count metric"
  value       = google_logging_metric.monitoring_error_count.name
}

output "monitoring_alert_policy" {
  description = "The name of the error alert policy"
  value       = google_monitoring_alert_policy.monitoring_error_alert.name
}

output "monitoring_notification_channel" {
  description = "The name of the email notification channel"
  value       = google_monitoring_notification_channel.monitoring_email.name
}
