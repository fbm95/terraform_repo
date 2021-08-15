resource "google_compute_firewall" "default_deny_egress" {
  name      = "default-deny-egress"
  project   = var.project_id
  network   = google_compute_network.shared_vpc_host.self_link
  direction = "EGRESS"
  priority  = 9999
  deny {
    protocol = "all"
  }
}

resource "google_compute_firewall" "default_deny_ingress" {
  name      = "default-deny-ingress"
  project   = var.project_id
  network   = google_compute_network.shared_vpc_host.self_link
  direction = "INGRESS"
  priority  = 9999
  deny {
    protocol = "all"
  }
}

resource "google_compute_firewall" "allow_ingress_ssh_iap" {
  project = var.project_id
  name    = "allow-ingress-ssh-iap"
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  priority = 500
}