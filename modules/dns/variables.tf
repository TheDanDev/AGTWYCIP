variable "project_id" {
  description = "The ID of the project where the DNS zone will be created"
  type        = string
}

variable "dns_zone_name" {
  description = "The name of the DNS zone"
  type        = string
}

variable "dns_name" {
  description = "The DNS name of the managed zone"
  type        = string
}

variable "enable_dnssec" {
  description = "Enable DNSSEC for the zone"
  type        = bool
  default     = true
}

variable "a_records" {
  description = "Map of A records to create"
  type        = map(list(string))
  default     = {}
}

variable "cname_records" {
  description = "Map of CNAME records to create"
  type        = map(string)
  default     = {}
}

variable "mx_records" {
  description = "List of MX records to create"
  type        = list(string)
  default     = null
}

variable "txt_records" {
  description = "Map of TXT records to create"
  type        = map(list(string))
  default     = {}
}

variable "a_record_ttl" {
  description = "TTL for A records"
  type        = number
  default     = 300
}

variable "cname_record_ttl" {
  description = "TTL for CNAME records"
  type        = number
  default     = 300
}

variable "mx_record_ttl" {
  description = "TTL for MX records"
  type        = number
  default     = 3600
}

variable "txt_record_ttl" {
  description = "TTL for TXT records"
  type        = number
  default     = 300
}
