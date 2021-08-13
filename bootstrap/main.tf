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
    google_project_service.dev_googleapis_enable
  ]
}

resource "google_project_iam_member" "editor_cloudbuild_sa" {
  project = var.dev_project_id
  role    = "roles/editor"
  member  = "serviceAccount:${data.google_project.dev_project.number}@cloudbuild.gserviceaccount.com"
  depends_on     = [google_project_service.dev_googleapis_enable]
}

resource "google_cloudbuild_trigger" "dev_infra_tf_plan_trigger" {
  project        = var.dev_project_id
  name           = "dev-infra-tf-plan"
  description    = "Terraform plan for dev infrastructure"
  filename       = "build/tf-plan.cloudbuild.yaml"
  depends_on     = [google_project_service.dev_googleapis_enable]

  github {
    owner   = "fbm95"
    name    = "terraform_repo"
    pull_request {
      branch = ".*"
    }
  }

}

resource "google_cloudbuild_trigger" "dev_infra_tf_apply_trigger" {
  project        = var.dev_project_id
  name           = "dev-infra-tf-apply"
  description    = "Terraform apply for dev infrastructure"
  filename       = "build/tf-apply.cloudbuild.yaml"
  depends_on     = [google_project_service.dev_googleapis_enable]

  github {
    owner   = "fbm95"
    name    = "terraform_repo"
    push {
      branch = "(dev|prod)"
    }
  }

}
