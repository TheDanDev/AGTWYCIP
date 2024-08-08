# Compute Module

This module sets up a Compute Engine instance in Google Cloud Platform for hosting WordPress and YOURLS.

## Usage

```hcl
module "compute" {
  source               = "./modules/compute"
  project_id           = "your-project-id"
  instance_name        = "wordpress-yourls-instance"
  machine_type         = "e2-medium"
  zone                 = "us-central1-a"
  network_name         = "your-network-name"
  subnetwork_name      = "your-subnetwork-name"
  ssh_public_key_path  = "~/.ssh/id_rsa.pub"
  startup_script_path  = "path/to/your/startup-script.sh"
  additional_tags      = ["wordpress", "yourls"]
  service_account_roles = [
    "roles/compute.viewer",
    "roles/storage.objectViewer",
  ]
}
