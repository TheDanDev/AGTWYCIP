variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for the database instances"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_network" {
  description = "The VPC network for the database instances"
  type        = string
}

variable "wordpress_instance_tier" {
  description = "The machine type for the WordPress database instance"
  type        = string
  default     = "db-n1-standard-1"
}

variable "yourls_instance_tier" {
  description = "The machine type for the YOURLS database instance"
  type        = string
  default     = "db-n1-standard-1"
}

variable "wordpress_replica_tier" {
  description = "The machine type for the WordPress read replica"
  type        = string
  default     = "db-n1-standard-1"
}

variable "yourls_replica_tier" {
  description = "The machine type for the YOURLS read replica"
  type        = string
  default     = "db-n1-standard-1"
}

variable "high_availability" {
  description = "Whether to enable high availability for the database instances"
  type        = bool
  default     = true
}

variable "create_read_replica" {
  description = "Whether to create read replicas for the database instances"
  type        = bool
  default     = true
}

variable "wordpress_max_connections" {
  description = "Maximum number of connections for WordPress database"
  type        = number
  default     = 100
}

variable "yourls_max_connections" {
  description = "Maximum number of connections for YOURLS database"
  type        = number
  default     = 50
}

variable "wordpress_db_user" {
  description = "Username for WordPress database"
  type        = string
}

variable "wordpress_db_password" {
  description = "Password for WordPress database user"
  type        = string
  sensitive   = true
}

variable "yourls_db_user" {
  description = "Username for YOURLS database"
  type        = string
}

variable "yourls_db_password" {
  description = "Password for YOURLS database user"
  type        = string
  sensitive   = true
}
