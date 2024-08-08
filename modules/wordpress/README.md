# WordPress Module

This module sets up a WordPress instance on Google Cloud Platform with various optimizations and security measures.

## Features

- Deploys WordPress on a Compute Engine instance
- Configures WordPress multisite (optional)
- Sets up WP-CLI for automated management tasks
- Configures object caching with Redis
- Implements security hardening measures
- Sets up Nginx as the web server

## Usage

```hcl
module "wordpress" {
  source = "./modules/wordpress"

  project_id     = var.project_id
  environment    = var.environment
  zone           = var.zone
  failover_zone  = var.failover_zone
  network        = module.network.network_self_link
  subnetwork     = module.network.subnetwork_self_link
  db_name        = module.database.wordpress_db_name
  db_user        = module.database.wordpress_db_user
  db_password    = module.database.wordpress_db_password
  db_host        = module.database.wordpress_db_host
  enable_multisite = true
  domain         = "www.example.com"
  allowed_ips    = ["203.0.113.0/24"]
}
