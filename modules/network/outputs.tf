output "network" {
  value = google_compute_network.vpc_network
}

output "subnetworks" {
  value = {
    "us-central1" = google_compute_subnetwork.subnetwork["us-central1"]
    "europe-west1" = google_compute_subnetwork.subnetwork["europe-west1"]
  }
}