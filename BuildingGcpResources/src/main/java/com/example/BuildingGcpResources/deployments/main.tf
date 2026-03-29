# Configure the Google Cloud Provider
provider "google" {
  project = "infra-data-416910" # Replace with your actual GCP Project ID
  region  = "asia-south1"      # Bengaluru/Mumbai region
}

# Create the Cloud SQL (PostgreSQL) Instance
resource "google_sql_database_instance" "postgres_instance" {
  name             = "dev-db-instance"
  database_version = "POSTGRES_15"
  region           = "asia-south1"
  deletion_protection = false # Set to true for production to prevent accidental deletion

  settings {
    tier = "db-f1-micro" # Smallest machine type (good for testing)

    ip_configuration {
      ipv4_enabled = true # Allows public IP access (secure this later with authorized networks)
    }
  }
}

# Create a specific database inside that instance
resource "google_sql_database" "database" {
  name     = "app_db"
  instance = google_sql_database_instance.postgres_instance.name
}

# Create a default user for the database
resource "google_sql_user" "users" {
  name     = "admin_user"
  instance = google_sql_database_instance.postgres_instance.name
  password = "your-secure-password" # Best practice: Use a Secret Manager later!
}