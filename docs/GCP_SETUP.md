# Google Cloud Platform (GCP) Setup Guide

This guide provides step-by-step instructions for setting up your Google Cloud Platform environment for Project Refurl.

## Prerequisites

- A Google Cloud Platform account
- `gcloud` CLI tool installed
- Terraform installed

## Steps

1. Create a new GCP project
gcloud projects create PROJECT_ID --name="Project Refurl"
2. Set the active project
gcloud config set project PROJECT_ID
3. Enable required APIs
gcloud services enable compute.googleapis.com
gcloud services enable cloudsql.googleapis.com
gcloud services enable cloudrun.googleapis.com
gcloud services enable containerregistry.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable secretmanager.googleapis.com
gcloud services enable cloudkms.googleapis.com
4. Create a service account for Terraform
gcloud iam service-accounts create terraform --display-name="Terraform Service Account"
5. Grant necessary permissions to the service account
gcloud projects add-iam-policy-binding PROJECT_ID --member="serviceAccount:terraform@PROJECT_ID.iam.gserviceaccount.com" --role="roles/owner"
6. Generate a key for the service account
gcloud iam service-accounts keys create terraform-key.json --iam-account=<terraform@PROJECT_ID.iam.gserviceaccount.com>
7. Set up application default credentials
gcloud auth application-default login
8. Configure Terraform to use the service account
Add the following to your Terraform configuration:

```hcl
provider "google" {
  credentials = file("path/to/terraform-key.json")
  project     = "PROJECT_ID"
  region      = "us-central1"
}

    Initialize Terraform

terraform init

Create a terraform.tfvars file with your project-specific variables
Run Terraform

    terraform plan
    terraform apply

Post-Setup Tasks

    Configure DNS settings for your custom domains
    Set up SSL certificates (if not using Google-managed SSL)
    Configure any additional security measures (e.g., IP allowlisting)
    Set up monitoring and alerting policies

Cleaning Up

To delete all created resources:

terraform destroy

Note: Be cautious when running terraform destroy as it will remove all resources managed by Terraform in your GCP project.

For more detailed information on each module and its setup, refer to the individual module README files in the modules/ directory.


These documents provide a comprehensive overview of the project, its architecture, modules, and setup process. They can be further customized based on specific implementation details and any additional features or considerations that arise during the development process.
