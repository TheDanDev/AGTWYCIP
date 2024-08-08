variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for the load balancer"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the load balancer"
  type        = string
}

variable "vpc_network" {
  description = "The VPC network for the load balancer"
  type        = string
}

variable "wordpress_instance_group" {
  description = "The instance group for WordPress backends"
  type        = string
}

variable "yourls_instance_group" {
  description = "The instance group for YOURLS backends"
  type        = string
}
