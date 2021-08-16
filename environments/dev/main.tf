resource "google_project_service" "dev_project_googleapis_enable" {
  project = var.project_id
  for_each = toset([
    "run.googleapis.com",
    "iam.googleapis.com",
    "iap.googleapis.com"
  ])
  service = each.value
  disable_on_destroy = false
}

resource "google_compute_instance" "wordpress" {
  project      = var.project_id
  name         = "wordpress"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  # scratch_disk {
  #   interface = "NVME"
  # }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20210720"
      size = 10
      type = "pd-ssd"
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

