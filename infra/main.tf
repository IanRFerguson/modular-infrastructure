terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.9.0"
    }
  }
}

provider "google" {
  // TODO - Make this abstract
  project = "ian-dev-444015"
}


module "client_foo" {
  source      = "./modules/client"
  client_name = "foo"
}

module "client_bar" {
  source           = "./modules/client"
  client_name      = "bar"
  provision_bucket = true
}
