# Load Balancer Module

This module sets up a Global HTTP(S) Load Balancer for WordPress and YOURLS instances on Google Cloud Platform.

## Features

- Distributes traffic between WordPress and YOURLS instances
- Implements SSL/TLS termination for secure connections
- Configures health checks for backend services
- Sets up routing rules for traffic distribution
- Integrates with Google-managed SSL certificates

## Usage

```hcl
module "load_balancer" {
  source = "./modules/load_balancer"

  project_id              = var.project_id
  region                  = var.region
  domain_name             = var.domain_name
  vpc_network             = module.network.vpc_network_name
  wordpress_instance_group = module.compute.wordpress_instance_group
  yourls_instance_group    = module.compute.yourls_instance_group
}
