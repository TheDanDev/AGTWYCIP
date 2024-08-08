# Storage Module

This module sets up Cloud Storage buckets for media files and backups, and configures Cloud CDN for improved media delivery on Google Cloud Platform.

## Features

- Creates separate Cloud Storage buckets for media files and backups
- Implements lifecycle policies for cost-effective storage management
- Configures object versioning for critical data
- Sets up Cloud CDN for improved media delivery
- Configures CORS for the media bucket
- Sets up IAM policies for bucket access

## Usage

```hcl
module "storage" {
  source = "./modules/storage"

  project_id   = var.project_id
  region       = var.region
  environment  = var.environment

  allowed_origins     = ["https://www.example.com"]
  media_bucket_viewers = ["serviceAccount:wordpress@${var.project_id}.iam.gserviceaccount.com"]
  backup_bucket_admins = ["serviceAccount:backup@${var.project_id}.iam.gserviceaccount.com"]
}
