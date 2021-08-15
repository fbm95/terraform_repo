resource "google_service_account" "wordpress_sa" {
  project = var.project_id
  account_id   = "wordpress-sa"
  display_name = "Wordpress Service Account"
}
