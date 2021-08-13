module "dev_network" {
  source            = "../../modules/network"
  project_id        = var.project_id
  region            = var.region
  subnet_cidr_range = "10.1.0.0/24"
}
