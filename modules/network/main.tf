resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = "${var.env_name}-vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnetwork" {
  for_each = var.subnetworks
  project       = var.project_id
  name          = "${each.value.subnet_region}-${var.env_name}-subnetwork"
  ip_cidr_range = subnet_cidr_range
  region        = each.value.subnet_region
  network       = google_compute_network.vpc_network.id
}
