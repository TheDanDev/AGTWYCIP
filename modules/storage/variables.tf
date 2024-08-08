variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for storage resources"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "media_file_retention_days" {
  description = "Number of days to retain media files"
  type        = number
  default     = 365
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 30
}

variable "allowed_origins" {
  description = "List of origins allowed for CORS"
  type        = list(string)
}

variable "media_bucket_viewers" {
  description = "List of members with object viewer access to media bucket"
  type        = list(string)
}

variable "backup_bucket_admins" {
  description = "List of members with object admin access to backup bucket"
  type        = list(string)
}
