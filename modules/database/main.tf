# Primary Cloud SQL instance for WordPress
resource "google_sql_database_instance" "database_wordpress_primary" {
  name             = "database-wordpress-primary-${var.environment}"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = var.wordpress_instance_tier
    availability_type = var.high_availability ? "REGIONAL" : "ZONAL"

    backup_configuration {
      enabled            = true
      start_time         = "02:00"
      binary_log_enabled = true
    }

    database_flags {
      name  = "max_connections"
      value = var.wordpress_max_connections
    }

    database_flags {
      name  = "slow_query_log"
      value = "on"
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_network
    }
  }

  deletion_protection = true
}

# Read replica for WordPress
resource "google_sql_database_instance" "database_wordpress_replica" {
  count                = var.create_read_replica ? 1 : 0
  name                 = "database-wordpress-replica-${var.environment}"
  master_instance_name = google_sql_database_instance.database_wordpress_primary.name
  region               = var.region
  database_version     = "MYSQL_8_0"

  replica_configuration {
    failover_target = false
  }

  settings {
    tier              = var.wordpress_replica_tier
    availability_type = "ZONAL"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_network
    }
  }

  deletion_protection = true
}

# WordPress database
resource "google_sql_database" "database_wordpress" {
  name     = "wordpress"
  instance = google_sql_database_instance.database_wordpress_primary.name
}

# WordPress user
resource "google_sql_user" "database_wordpress_user" {
  name     = var.wordpress_db_user
  instance = google_sql_database_instance.database_wordpress_primary.name
  password = var.wordpress_db_password
}

# Primary Cloud SQL instance for YOURLS
resource "google_sql_database_instance" "database_yourls_primary" {
  name             = "database-yourls-primary-${var.environment}"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = var.yourls_instance_tier
    availability_type = var.high_availability ? "REGIONAL" : "ZONAL"

    backup_configuration {
      enabled            = true
      start_time         = "03:00"
      binary_log_enabled = true
    }

    database_flags {
      name  = "max_connections"
      value = var.yourls_max_connections
    }

    database_flags {
      name  = "slow_query_log"
      value = "on"
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_network
    }
  }

  deletion_protection = true
}

# Read replica for YOURLS
resource "google_sql_database_instance" "database_yourls_replica" {
  count                = var.create_read_replica ? 1 : 0
  name                 = "database-yourls-replica-${var.environment}"
  master_instance_name = google_sql_database_instance.database_yourls_primary.name
  region               = var.region
  database_version     = "MYSQL_8_0"

  replica_configuration {
    failover_target = false
  }

  settings {
    tier              = var.yourls_replica_tier
    availability_type = "ZONAL"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_network
    }
  }

  deletion_protection = true
}

# YOURLS database
resource "google_sql_database" "database_yourls" {
  name     = "yourls"
  instance = google_sql_database_instance.database_yourls_primary.name
}

# YOURLS user
resource "google_sql_user" "database_yourls_user" {
  name     = var.yourls_db_user
  instance = google_sql_database_instance.database_yourls_primary.name
  password = var.yourls_db_password
}
