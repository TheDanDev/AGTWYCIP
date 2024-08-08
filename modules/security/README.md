# Security Module

This module implements security configurations and policies for the Refurl project on Google Cloud Platform.

## Features

- IAM policies and access control
- Secret Manager for storing sensitive credentials
- Integration with Security Command Center
- VPC Service Controls (optional)
- Cloud KMS for key management

## Usage

```hcl
module "security" {
  source = "./modules/security"

  project_id       = var.project_id
  project_number   = var.project_number
  organization_id  = var.organization_id
  region           = var.region
  project_roles    = var.project_roles
  secrets          = var.secrets
  enable_vpc_service_controls = true
  restricted_services = ["storage.googleapis.com", "bigquery.googleapis.com"]
}
