variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

variable "region" {
  description = "The region where the NAT gateway will be created"
  type        = string
}

variable "network_name" {
  description = "The name of the network being created"
  type        = string
}

variable "subnets" {
  type = map(object({
    cidr             = string
    region           = string
    secondary_ranges = list(string)
  }))
  description = "The list of subnets being created"
}

variable "ssh_source_ranges" {
  type        = list(string)
  description = "List of CIDR blocks from which SSH access is allowed"
  default     = ["0.0.0.0/0"]
}
