terraform {
  backend "gcs" {
    bucket = "bfusa-dev-tf-state"
    prefix = "env/dev"
  }
}