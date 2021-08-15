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
  subnetworks       = var.subnetworks
}

resource "google_service_account" "wordpress_sa" {
  project = var.project_id
  account_id   = "wordpress-sa"
  display_name = "Wordpress Service Account"
}

resource "google_compute_instance" "default" {
  name         = "wordpress"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = module.dev_network.network_name

    access_config {
      // Ephemeral IP automatic assignment
    }
  }

  service_account {
    email  = google_service_account.wordpress_sa.email
    scopes = ["cloud-platform"]
  }
}