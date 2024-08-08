# Monitoring Module

This module sets up monitoring and logging for the WordPress and YOURLS infrastructure on Google Cloud Platform.

## Features

- Cloud Monitoring dashboard for WordPress and YOURLS
- Logging sinks for WordPress and YOURLS instances
- Custom log-based metrics for error tracking
- Alert policies for critical events
- Uptime checks for WordPress and YOURLS endpoints
- Email notifications for alerts

## Usage

```hcl
module "monitoring" {
  source = "./modules/monitoring"

  project_id           = var.project_id
  region               = var.region
  wordpress_instance_id = module.compute.wordpress_instance_id
  yourls_instance_id    = module.compute.yourls_instance_id
  alert_email          = "alerts@example.com"
  wordpress_domain     = "www.example.com"
  yourls_domain        = "yourls.example.com"
}
