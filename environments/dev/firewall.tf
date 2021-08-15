resource "google_compute_firewall" "default_deny_egress" {
  name      = "default-deny-egress"
  project   = var.project_id
  network   = module.dev_network.network.self_link
  direction = "EGRESS"
  priority  = 9999
  deny {
    protocol = "all"
  }
}

resource "google_compute_firewall" "default_deny_ingress" {
  name      = "default-deny-ingress"
  project   = var.project_id
  network   = module.dev_network.network.self_link
  direction = "INGRESS"
  priority  = 9999
  deny {
    protocol = "all"
  }
}

resource "google_compute_firewall" "allow_ingress_ssh_iap" {
  project = var.project_id
  name    = "allow-ingress-ssh-iap"
  network   = module.dev_network.network.self_link
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
  target_service_accounts = [
    google_service_account.wordpress_sa.email
  ]
  priority = 500

}
