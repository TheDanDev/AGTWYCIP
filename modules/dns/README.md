# DNS Module

This module sets up a DNS zone and records in Google Cloud DNS for WordPress and YOURLS domains.

## Usage

```hcl
module "dns" {
  source        = "./modules/dns"
  project_id    = "your-project-id"
  dns_zone_name = "example-zone"
  dns_name      = "example.com."
  enable_dnssec = true
  a_records     = {
    "@"     = ["203.0.113.1"]
    "www"   = ["203.0.113.1"]
    "yourls" = ["203.0.113.2"]
  }
  cname_records = {
    "blog" = "wordpress.example.com."
  }
  mx_records    = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
    "10 alt4.aspmx.l.google.com."
  ]
  txt_records   = {
    "@" = ["v=spf1 include:_spf.google.com ~all"]
  }
}
