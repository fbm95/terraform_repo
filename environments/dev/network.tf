module "dev_network" {
  source            = "../../modules/network"
  project_id        = var.project_id
  region            = var.region
  env_name          = var.env_name
  subnetworks       = var.subnetworks
}

output "subnet" {
  value = module.dev_network.subnetworks
}
