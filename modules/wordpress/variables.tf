variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "machine_type" {
  description = "The machine type for the WordPress instance"
  type        = string
  default     = "e2-medium"
}

variable "zone" {
  description = "The GCP zone for the WordPress instance"
  type        = string
}

variable "failover_zone" {
  description = "The GCP zone for Redis failover"
  type        = string
}

variable "network" {
  description = "The VPC network for the WordPress instance"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork for the WordPress instance"
  type        = string
}

variable "db_name" {
  description = "The WordPress database name"
  type        = string
}

variable "db_user" {
  description = "The WordPress database user"
  type        = string
}

variable "db_password" {
  description = "The WordPress database password"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "The WordPress database host"
  type        = string
}

variable "enable_multisite" {
  description = "Whether to enable WordPress multisite"
  type        = bool
  default     = false
}

variable "redis_host" {
  description = "The Redis host for object caching"
  type        = string
}

variable "domain" {
  description = "The domain for the WordPress site"
  type        = string
}

variable "allowed_ips" {
  description = "List of IP ranges allowed to access WordPress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
