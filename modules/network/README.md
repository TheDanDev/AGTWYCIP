# Network Module

This module sets up a VPC network with subnets, firewall rules, and a NAT gateway in Google Cloud Platform.

## Usage

```hcl
module "network" {
  source       = "./modules/network"
  project_id   = "your-project-id"
  region       = "us-central1"
  network_name = "my-network"
  subnets = {
    dev = {
      cidr             = "10.0.1.0/24"
      region           = "us-central1"
      secondary_ranges = ["10.1.0.0/24"]
    },
    staging = {
      cidr             = "10.0.2.0/24"
      region           = "us-central1"
      secondary_ranges = ["10.2.0.0/24"]
    },
    prod = {
      cidr             = "10.0.3.0/24"
      region           = "us-central1"
      secondary_ranges = ["10.3.0.0/24"]
    }
  }
  ssh_source_ranges = ["35.235.240.0/20"] # Example: GCP Identity-Aware Proxy range
}
