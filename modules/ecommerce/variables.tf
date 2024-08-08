variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
}

variable "zone" {
  description = "The zone to deploy resources"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "machine_type" {
  description = "The machine type for the e-commerce instance"
  type        = string
  default     = "e2-medium"
}

variable "wordpress_db_name" {
  description = "WordPress database name"
  type        = string
}

variable "wordpress_db_user" {
  description = "WordPress database user"
  type        = string
}

variable "wordpress_db_password" {
  description = "WordPress database password"
  type        = string
}

variable "wordpress_db_host" {
  description = "WordPress database host"
  type        = string
}

variable "inventory_db_connection_string" {
  description = "Connection string for the inventory database"
  type        = string
}
