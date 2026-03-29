resources "google_sql_database_instance" "postgres_instance"{
    name = "dev-db-instance"
    database_version = "POSTGRES_15"
    region = "asia-south1"
    }

settings {
    tier = "db-f1-micro" # Choose based on workload
  }
}

resources "google_sql_database" "database"{
    name = "app_db"
    instance = google_sql_database_instance.postgres_instance.name
    }