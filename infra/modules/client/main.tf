// Create client-specific service account
resource "google_service_account" "service_account" {
  account_id   = "sa-${var.client_name}"
  display_name = "Client service account for ${upper(var.client_name)}"
}

// BigQuery datasets
resource "google_bigquery_dataset" "prod" {
  dataset_id    = "${var.client_name}__prod"
  friendly_name = "${var.client_name}__prod"
  description   = "Production BigQuery dataset for ${upper(var.client_name)}"
  location      = var.bigquery-region
}

resource "google_bigquery_dataset" "scratch" {
  dataset_id                  = "${var.client_name}__scratch"
  friendly_name               = "${var.client_name}__scratch"
  description                 = "Scratch BigQuery dataset for ${upper(var.client_name)}"
  location                    = var.bigquery-region
  default_table_expiration_ms = var.default_table_expiration
}

// BigQuery IAM
resource "google_bigquery_dataset_iam_member" "prod-editor" {
  dataset_id = google_bigquery_dataset.prod.friendly_name
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_bigquery_dataset_iam_member" "scratch-editor" {
  dataset_id = google_bigquery_dataset.scratch.friendly_name
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${google_service_account.service_account.email}"
}

// Cloud storage
resource "google_storage_bucket" "default" {
  count    = var.provision_bucket ? 1 : 0
  name     = "bkt-${var.client_name}"
  location = var.gcs-region
}

resource "google_storage_bucket_iam_member" "member" {
  count  = var.provision_bucket ? 1 : 0
  bucket = google_storage_bucket.default[count.index].name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.service_account.email}"
}
