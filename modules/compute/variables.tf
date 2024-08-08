variable "project_id" {
  description = "The ID of the project where this instance will be created"
  type        = string
}

variable "instance_name" {
  description = "The name of the compute instance"
  type        = string
}

variable "machine_type" {
  description = "The machine type of the compute instance"
  type        = string
  default     = "e2-medium"
}

variable "zone" {
  description = "The zone where the compute instance will be created"
  type        = string
}

variable "instance_image" {
  description = "The image to use for the compute instance"
  type        = string
  default     = "debian-cloud/debian-10"
}

variable "boot_disk_size" {
  description = "The size of the boot disk in GB"
  type        = number
  default     = 20
}

variable "boot_disk_type" {
  description = "The type of the boot disk"
  type        = string
  default     = "pd-standard"
}

variable "network_name" {
  description = "The name of the network to attach the instance to"
  type        = string
}

variable "subnetwork_name" {
  description = "The name of the subnetwork to attach the instance to"
  type        = string
}

variable "ssh_user" {
  description = "The user for SSH access"
  type        = string
  default     = "admin"
}

variable "ssh_public_key_path" {
  description = "The path to the public SSH key"
  type        = string
}

variable "startup_script_path" {
  description = "The path to the startup script"
  type        = string
}

variable "additional_tags" {
  description = "Additional network tags to apply to the instance"
  type        = list(string)
  default     = []
}

variable "service_account_roles" {
  description = "The roles to assign to the service account"
  type        = list(string)
  default     = [
    "roles/compute.viewer",
    "roles/storage.objectViewer",
  ]
}
