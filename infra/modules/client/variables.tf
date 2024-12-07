variable "client_name" {
  type = string
}

// BigQuery variables
variable "bigquery-region" {
  type    = string
  default = "us"
}

variable "default_table_expiration" {
  type    = number
  default = (3600000 * 24 * 7 * 2)
}

// Cloud Storage variables
variable "gcs-region" {
  type    = string
  default = "us-east1"
}

variable "provision_bucket" {
  type    = bool
  default = false
}
