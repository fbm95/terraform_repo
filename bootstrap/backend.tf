# first run terraform init, plan and apply with local backend
# then comment local backend, uncomment gcs backend 
# and run `terraform init -migrate-state` to move the state to GCS 

# terraform {
#   backend "local" {
#     path = "bootstrap.tfstate"
#   }
# }

terraform {
  backend "gcs" {
    bucket = "bfusa-dev-tf-state"
    prefix = "env/bootstrap"
  }
}
