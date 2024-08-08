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

variable "machine_type" {
  description = "The machine type for the YOURLS instance"
  type        = string
  default     = "e2-medium"
}

variable "domain_name" {
  description = "The domain name for YOURLS"
  type        = string
}

variable "dns_zone" {
  description = "The DNS zone name in Cloud DNS"
  type        = string
}
