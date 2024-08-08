# E-commerce Module

This module sets up an e-commerce solution using WooCommerce integrated with WordPress on Google Cloud Platform.

## Features

- WooCommerce integration with WordPress
- Multiple payment gateways (Stripe and PayPal)
- Support for multiple currencies
- Inventory management system
- Tax rules for different regions
- Performance optimization for WooCommerce

## Usage

```hcl
module "ecommerce" {
  source = "./modules/ecommerce"

  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  environment  = var.environment

  wordpress_db_name     = var.wordpress_db_name
  wordpress_db_user     = var.wordpress_db_user
  wordpress_db_password = var.wordpress_db_password
  wordpress_db_host     = var.wordpress_db_host

  inventory_db_connection_string = var.inventory_db_connection_string
}
