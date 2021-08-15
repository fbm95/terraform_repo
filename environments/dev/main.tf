resource "google_project_service" "dev_project_googleapis_enable" {
  project = var.project_id
  for_each = toset([
    "run.googleapis.com",
    "iam.googleapis.com"
  ])
  service = each.value
  disable_on_destroy = false
}

resource "google_compute_instance" "wordpress" {
  project      = var.project_id
  name         = "wordpress"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = module.dev_network.network.name
    subnetwork = module.dev_network.subnetworks["us-central1"].self_link

    access_config {
      // Ephemeral IP automatic assignment
    }
  }

  service_account {
    email  = google_service_account.wordpress_sa.email
    scopes = ["cloud-platform"]
  }
}

