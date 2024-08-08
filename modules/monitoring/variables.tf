variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resources"
  type        = string
}

variable "wordpress_instance_id" {
  description = "The instance ID of the WordPress VM"
  type        = string
}

variable "yourls_instance_id" {
  description = "The instance ID of the YOURLS VM"
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to retain logs"
  type        = number
  default     = 30
}

variable "alert_email" {
  description = "Email address for alert notifications"
  type        = string
}

variable "wordpress_domain" {
  description = "Domain name for WordPress site"
  type        = string
}

variable "yourls_domain" {
  description = "Domain name for YOURLS site"
  type        = string
}
