variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "project_number" {
  description = "The GCP project number"
  type        = string
}

variable "organization_id" {
  description = "The GCP organization ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resources"
  type        = string
}

variable "project_roles" {
  description = "Map of roles to member lists for project IAM"
  type        = map(list(string))
}

variable "secrets" {
  description = "Map of secret names to their values"
  type        = map(string)
  sensitive   = true
}

variable "enable_vpc_service_controls" {
  description = "Whether to enable VPC Service Controls"
  type        = bool
  default     = false
}

variable "restricted_services" {
  description = "List of services to restrict with VPC Service Controls"
  type        = list(string)
  default     = []
}
