# YOURLS Module

This module sets up YOURLS (Your Own URL Shortener) on Google Cloud Platform.

## Features

- Custom domain support
- Advanced analytics and link management plugins
- API access for programmatic link creation
- Rate limiting and abuse prevention measures

## Usage

```hcl
module "yourls" {
  source      = "./modules/yourls"
  project_id  = var.project_id
  region      = var.region
  zone        = var.zone
  domain_name = var.yourls_domain
  dns_zone    = var.dns_zone
}
