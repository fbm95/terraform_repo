resource "google_project_service" "dev_project_googleapis_enable" {
  project = var.project_id
  for_each = toset([
    "run.googleapis.com"
  ])
  service = each.value
  disable_on_destroy = false
}

module "dev_network" {
  source            = "../../modules/network"
  project_id        = var.project_id
  region            = var.region
  env_name          = var.env_name
  subnet_cidr_range = "10.1.0.0/24"
}
