resource "google_dns_managed_zone" "dns_zone" {
  name        = var.dns_zone_name
  dns_name    = var.dns_name
  description = "Managed DNS zone for ${var.dns_name}"
  project     = var.project_id

  dnssec_config {
    state = var.enable_dnssec ? "on" : "off"
  }
}

resource "google_dns_record_set" "dns_a_record" {
  for_each = var.a_records

  name         = each.key == "@" ? google_dns_managed_zone.dns_zone.dns_name : "${each.key}.${google_dns_managed_zone.dns_zone.dns_name}"
  managed_zone = google_dns_managed_zone.dns_zone.name
  type         = "A"
  ttl          = var.a_record_ttl
  rrdatas      = each.value
  project      = var.project_id
}

resource "google_dns_record_set" "dns_cname_record" {
  for_each = var.cname_records

  name         = "${each.key}.${google_dns_managed_zone.dns_zone.dns_name}"
  managed_zone = google_dns_managed_zone.dns_zone.name
  type         = "CNAME"
  ttl          = var.cname_record_ttl
  rrdatas      = [each.value]
  project      = var.project_id
}

resource "google_dns_record_set" "dns_mx_record" {
  count = var.mx_records != null ? 1 : 0

  name         = google_dns_managed_zone.dns_zone.dns_name
  managed_zone = google_dns_managed_zone.dns_zone.name
  type         = "MX"
  ttl          = var.mx_record_ttl
  rrdatas      = var.mx_records
  project      = var.project_id
}

resource "google_dns_record_set" "dns_txt_record" {
  for_each = var.txt_records

  name         = each.key == "@" ? google_dns_managed_zone.dns_zone.dns_name : "${each.key}.${google_dns_managed_zone.dns_zone.dns_name}"
  managed_zone = google_dns_managed_zone.dns_zone.name
  type         = "TXT"
  ttl          = var.txt_record_ttl
  rrdatas      = each.value
  project      = var.project_id
}
