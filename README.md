# Designing Mdoular Infrastructure with Terraform

This repo offers a brief example of how to create and run modular Terraform.

## Source Code
You'll find all of the relevant source code in `infra/` ... the `client` module is defined in `modules/client/main.tf` and will stand up BigQuery and Cloud Storage resources, as well as a client-specific service account.

```
module "client_example" {
  source           = "./modules/client"
  client_name      = "example"
  provision_bucket = true
}
```