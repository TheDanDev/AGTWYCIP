# Database Module

This module sets up Cloud SQL instances for WordPress and YOURLS on Google Cloud Platform.

## Features

- Deploys separate Cloud SQL instances for WordPress and YOURLS
- Implements read replicas for improved performance (optional)
- Sets up automated backups and enables point-in-time recovery
- Configures database flags for optimal performance
- Supports high availability configuration
- Implements private IP for enhanced security

## Usage

```hcl
module "database" {
  source = "./modules/database"

  project_id   = var.project_id
  region       = var.region
  environment  = var.environment
  vpc_network  = module.network.vpc_network_self_link

  wordpress_db_user     = var.wordpress_db_user
  wordpress_db_password = var.wordpress_db_password
  yourls_db_user        = var.yourls_db_user
  yourls_db_password    = var.yourls_db_password

  high_availability   = true
  create_read_replica = true
}
