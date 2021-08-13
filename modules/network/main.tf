resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = "${var.env_name}-vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "${var.region}-${var.env_name}-subnetwork"
  ip_cidr_range = var.subnet_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

