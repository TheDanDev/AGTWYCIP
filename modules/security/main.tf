# IAM Policies
resource "google_project_iam_binding" "security_project_roles" {
  for_each = var.project_roles
  project  = var.project_id
  role     = each.key

  members = each.value
}

# Secret Manager
resource "google_secret_manager_secret" "security_secrets" {
  for_each  = var.secrets
  secret_id = each.key

  replication {}
}

resource "google_secret_manager_secret_version" "security_secret_versions" {
  for_each    = var.secrets
  secret      = google_secret_manager_secret.security_secrets[each.key].id
  secret_data = each.value
}

# Security Command Center
resource "google_scc_source" "security_scc_source" {
  display_name = "Refurl Security Source"
  organization = var.organization_id
  description  = "Security source for Refurl project"
}

# VPC Service Controls
resource "google_access_context_manager_access_policy" "security_access_policy" {
  count  = var.enable_vpc_service_controls ? 1 : 0
  parent = "organizations/${var.organization_id}"
  title  = "Refurl Access Policy"
}

resource "google_access_context_manager_service_perimeter" "security_service_perimeter" {
  count          = var.enable_vpc_service_controls ? 1 : 0
  parent         = google_access_context_manager_access_policy.security_access_policy[0].name
  name           = "accessPolicies/${google_access_context_manager_access_policy.security_access_policy[0].name}/servicePerimeters/refurl_perimeter"
  title          = "Refurl Service Perimeter"
  perimeter_type = "PERIMETER_TYPE_REGULAR"

  status {
    restricted_services = var.restricted_services
    resources           = ["projects/${var.project_number}"]
  }
}

# Cloud KMS
resource "google_kms_key_ring" "security_key_ring" {
  name     = "security-key-ring"
  location = var.region
}

resource "google_kms_crypto_key" "security_crypto_key" {
  name            = "security-crypto-key"
  key_ring        = google_kms_key_ring.security_key_ring.id
  rotation_period = "7776000s" # 90 days

  lifecycle {
    prevent_destroy = true
  }
}
