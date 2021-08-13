module "dev_terraform_state_bucket" {
  source        = "github.com/terraform-google-modules/terraform-google-cloud-storage///modules/simple_bucket?ref=v2.1.0"
  name          = "bfusa-dev-tf-state"
  project_id    = var.dev_project_id
  location      = var.bucket_location
  force_destroy = true
}

resource "google_project_service" "dev_googleapis_enable" {
  project = var.dev_project_id
  for_each = toset([
    "cloudbuild.googleapis.com",
    "compute.googleapis.com"
  ])
  service = each.value
  disable_on_destroy = false
}

data "google_project" "dev_project" {
  project_id = var.dev_project_id
}

resource "google_storage_bucket_iam_member" "dev_cb_tfstate_iam" {
  bucket = module.dev_terraform_state_bucket.bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${data.google_project.dev_project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    module.dev_terraform_state_bucket,
  ]
}
