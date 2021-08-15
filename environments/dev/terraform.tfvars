region               = "europe-west1"
project_id           = "dev-playground-2168"
env_name             = "dev"
dev_artifacts_bucket = "bfusa-dev-cb-artifacts"

subnetworks          = [{
    subnet_region     = "europe-west1"
    subnet_cidr_range = "10.1.0.0/24"
  },
  {
    subnet_region     = "us-central1"
    subnet_cidr_range = "10.2.0.0/24"
  }]
