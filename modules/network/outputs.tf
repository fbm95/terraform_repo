output "network_name" {
  value = google_compute_network.vpc_network.name
}

output "subnetworks" {
  value = {
    "us-central1" = google_compute_subnetwork.subnetwork["us-central1"]
    "europe-west1" = google_compute_subnetwork.subnetwork["europe-west1"]
  }
}